
obj/user/arrayOperations_mergesort:     file format elf32-i386


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
  800031:	e8 3d 04 00 00       	call   800473 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

//int *Left;
//int *Right;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 bf 18 00 00       	call   801902 <sys_getparentenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  800046:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int *sharedArray = NULL;
  80004d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	sharedArray = sget(parentenvID, "arr") ;
  800054:	83 ec 08             	sub    $0x8,%esp
  800057:	68 e0 22 80 00       	push   $0x8022e0
  80005c:	ff 75 f0             	pushl  -0x10(%ebp)
  80005f:	e8 36 17 00 00       	call   80179a <sget>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 e8             	mov    %eax,-0x18(%ebp)
	numOfElements = sget(parentenvID, "arrSize") ;
  80006a:	83 ec 08             	sub    $0x8,%esp
  80006d:	68 e4 22 80 00       	push   $0x8022e4
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 20 17 00 00       	call   80179a <sget>
  80007a:	83 c4 10             	add    $0x10,%esp
  80007d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//PrintElements(sharedArray, *numOfElements);

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800080:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	finishedCount = sget(parentenvID, "finishedCount") ;
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	68 ec 22 80 00       	push   $0x8022ec
  80008f:	ff 75 f0             	pushl  -0x10(%ebp)
  800092:	e8 03 17 00 00       	call   80179a <sget>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
  80009d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000a0:	8b 00                	mov    (%eax),%eax
  8000a2:	c1 e0 02             	shl    $0x2,%eax
  8000a5:	83 ec 04             	sub    $0x4,%esp
  8000a8:	6a 00                	push   $0x0
  8000aa:	50                   	push   %eax
  8000ab:	68 fa 22 80 00       	push   $0x8022fa
  8000b0:	e8 c2 16 00 00       	call   801777 <smalloc>
  8000b5:	83 c4 10             	add    $0x10,%esp
  8000b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c2:	eb 25                	jmp    8000e9 <_main+0xb1>
	{
		sortedArray[i] = sharedArray[i];
  8000c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000d1:	01 c2                	add    %eax,%edx
  8000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	01 c8                	add    %ecx,%eax
  8000e2:	8b 00                	mov    (%eax),%eax
  8000e4:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000e6:	ff 45 f4             	incl   -0xc(%ebp)
  8000e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f1:	7f d1                	jg     8000c4 <_main+0x8c>
	}
//	//Create two temps array for "left" & "right"
//	Left = smalloc("mergesortLeftArr", sizeof(int) * (*numOfElements), 1) ;
//	Right = smalloc("mergesortRightArr", sizeof(int) * (*numOfElements), 1) ;

	MSort(sortedArray, 1, *numOfElements);
  8000f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000f6:	8b 00                	mov    (%eax),%eax
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	50                   	push   %eax
  8000fc:	6a 01                	push   $0x1
  8000fe:	ff 75 e0             	pushl  -0x20(%ebp)
  800101:	e8 fc 00 00 00       	call   800202 <MSort>
  800106:	83 c4 10             	add    $0x10,%esp
	cprintf("Merge sort is Finished!!!!\n") ;
  800109:	83 ec 0c             	sub    $0xc,%esp
  80010c:	68 09 23 80 00       	push   $0x802309
  800111:	e8 76 05 00 00       	call   80068c <cprintf>
  800116:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  800119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011c:	8b 00                	mov    (%eax),%eax
  80011e:	8d 50 01             	lea    0x1(%eax),%edx
  800121:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800124:	89 10                	mov    %edx,(%eax)

}
  800126:	90                   	nop
  800127:	c9                   	leave  
  800128:	c3                   	ret    

00800129 <Swap>:

void Swap(int *Elements, int First, int Second)
{
  800129:	55                   	push   %ebp
  80012a:	89 e5                	mov    %esp,%ebp
  80012c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80012f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800132:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800139:	8b 45 08             	mov    0x8(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8b 00                	mov    (%eax),%eax
  800140:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800143:	8b 45 0c             	mov    0xc(%ebp),%eax
  800146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80014d:	8b 45 08             	mov    0x8(%ebp),%eax
  800150:	01 c2                	add    %eax,%edx
  800152:	8b 45 10             	mov    0x10(%ebp),%eax
  800155:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80015c:	8b 45 08             	mov    0x8(%ebp),%eax
  80015f:	01 c8                	add    %ecx,%eax
  800161:	8b 00                	mov    (%eax),%eax
  800163:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800165:	8b 45 10             	mov    0x10(%ebp),%eax
  800168:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80016f:	8b 45 08             	mov    0x8(%ebp),%eax
  800172:	01 c2                	add    %eax,%edx
  800174:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800177:	89 02                	mov    %eax,(%edx)
}
  800179:	90                   	nop
  80017a:	c9                   	leave  
  80017b:	c3                   	ret    

0080017c <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  80017c:	55                   	push   %ebp
  80017d:	89 e5                	mov    %esp,%ebp
  80017f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800182:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800189:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800190:	eb 42                	jmp    8001d4 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800192:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800195:	99                   	cltd   
  800196:	f7 7d f0             	idivl  -0x10(%ebp)
  800199:	89 d0                	mov    %edx,%eax
  80019b:	85 c0                	test   %eax,%eax
  80019d:	75 10                	jne    8001af <PrintElements+0x33>
			cprintf("\n");
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	68 25 23 80 00       	push   $0x802325
  8001a7:	e8 e0 04 00 00       	call   80068c <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8001af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	8b 00                	mov    (%eax),%eax
  8001c0:	83 ec 08             	sub    $0x8,%esp
  8001c3:	50                   	push   %eax
  8001c4:	68 27 23 80 00       	push   $0x802327
  8001c9:	e8 be 04 00 00       	call   80068c <cprintf>
  8001ce:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8001d1:	ff 45 f4             	incl   -0xc(%ebp)
  8001d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d7:	48                   	dec    %eax
  8001d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001db:	7f b5                	jg     800192 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8001dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8001ea:	01 d0                	add    %edx,%eax
  8001ec:	8b 00                	mov    (%eax),%eax
  8001ee:	83 ec 08             	sub    $0x8,%esp
  8001f1:	50                   	push   %eax
  8001f2:	68 2c 23 80 00       	push   $0x80232c
  8001f7:	e8 90 04 00 00       	call   80068c <cprintf>
  8001fc:	83 c4 10             	add    $0x10,%esp

}
  8001ff:	90                   	nop
  800200:	c9                   	leave  
  800201:	c3                   	ret    

00800202 <MSort>:


void MSort(int* A, int p, int r)
{
  800202:	55                   	push   %ebp
  800203:	89 e5                	mov    %esp,%ebp
  800205:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80020e:	7d 54                	jge    800264 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  800210:	8b 55 0c             	mov    0xc(%ebp),%edx
  800213:	8b 45 10             	mov    0x10(%ebp),%eax
  800216:	01 d0                	add    %edx,%eax
  800218:	89 c2                	mov    %eax,%edx
  80021a:	c1 ea 1f             	shr    $0x1f,%edx
  80021d:	01 d0                	add    %edx,%eax
  80021f:	d1 f8                	sar    %eax
  800221:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	ff 75 f4             	pushl  -0xc(%ebp)
  80022a:	ff 75 0c             	pushl  0xc(%ebp)
  80022d:	ff 75 08             	pushl  0x8(%ebp)
  800230:	e8 cd ff ff ff       	call   800202 <MSort>
  800235:	83 c4 10             	add    $0x10,%esp
//	cprintf("LEFT is sorted: from %d to %d\n", p, q);

	MSort(A, q + 1, r);
  800238:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80023b:	40                   	inc    %eax
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	ff 75 10             	pushl  0x10(%ebp)
  800242:	50                   	push   %eax
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 b7 ff ff ff       	call   800202 <MSort>
  80024b:	83 c4 10             	add    $0x10,%esp
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
  80024e:	ff 75 10             	pushl  0x10(%ebp)
  800251:	ff 75 f4             	pushl  -0xc(%ebp)
  800254:	ff 75 0c             	pushl  0xc(%ebp)
  800257:	ff 75 08             	pushl  0x8(%ebp)
  80025a:	e8 08 00 00 00       	call   800267 <Merge>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	eb 01                	jmp    800265 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800264:	90                   	nop
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
	//cprintf("[%d %d] + [%d %d] = [%d %d]\n", p, q, q+1, r, p, r);

}
  800265:	c9                   	leave  
  800266:	c3                   	ret    

00800267 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800267:	55                   	push   %ebp
  800268:	89 e5                	mov    %esp,%ebp
  80026a:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80026d:	8b 45 10             	mov    0x10(%ebp),%eax
  800270:	2b 45 0c             	sub    0xc(%ebp),%eax
  800273:	40                   	inc    %eax
  800274:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800277:	8b 45 14             	mov    0x14(%ebp),%eax
  80027a:	2b 45 10             	sub    0x10(%ebp),%eax
  80027d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800280:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800287:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  80028e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800291:	c1 e0 02             	shl    $0x2,%eax
  800294:	83 ec 0c             	sub    $0xc,%esp
  800297:	50                   	push   %eax
  800298:	e8 79 11 00 00       	call   801416 <malloc>
  80029d:	83 c4 10             	add    $0x10,%esp
  8002a0:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  8002a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a6:	c1 e0 02             	shl    $0x2,%eax
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	50                   	push   %eax
  8002ad:	e8 64 11 00 00       	call   801416 <malloc>
  8002b2:	83 c4 10             	add    $0x10,%esp
  8002b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8002bf:	eb 2f                	jmp    8002f0 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8002c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002ce:	01 c2                	add    %eax,%edx
  8002d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002d6:	01 c8                	add    %ecx,%eax
  8002d8:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8002dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 c8                	add    %ecx,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
  8002eb:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002ed:	ff 45 ec             	incl   -0x14(%ebp)
  8002f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002f6:	7c c9                	jl     8002c1 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8002f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002ff:	eb 2a                	jmp    80032b <Merge+0xc4>
	{
		Right[j] = A[q + j];
  800301:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800304:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80030e:	01 c2                	add    %eax,%edx
  800310:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800313:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800316:	01 c8                	add    %ecx,%eax
  800318:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80031f:	8b 45 08             	mov    0x8(%ebp),%eax
  800322:	01 c8                	add    %ecx,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800328:	ff 45 e8             	incl   -0x18(%ebp)
  80032b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80032e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800331:	7c ce                	jl     800301 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800333:	8b 45 0c             	mov    0xc(%ebp),%eax
  800336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800339:	e9 0a 01 00 00       	jmp    800448 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  80033e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800341:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800344:	0f 8d 95 00 00 00    	jge    8003df <Merge+0x178>
  80034a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034d:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800350:	0f 8d 89 00 00 00    	jge    8003df <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800356:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800360:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	8b 10                	mov    (%eax),%edx
  800367:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800371:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800374:	01 c8                	add    %ecx,%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	39 c2                	cmp    %eax,%edx
  80037a:	7d 33                	jge    8003af <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80037c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80037f:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800384:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800394:	8d 50 01             	lea    0x1(%eax),%edx
  800397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80039a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003aa:	e9 96 00 00 00       	jmp    800445 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  8003af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003b2:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c7:	8d 50 01             	lea    0x1(%eax),%edx
  8003ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8003cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003dd:	eb 66                	jmp    800445 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8003e5:	7d 30                	jge    800417 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8003e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003ea:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ff:	8d 50 01             	lea    0x1(%eax),%edx
  800402:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80040f:	01 d0                	add    %edx,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	89 01                	mov    %eax,(%ecx)
  800415:	eb 2e                	jmp    800445 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800417:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80041a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80041f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80042f:	8d 50 01             	lea    0x1(%eax),%edx
  800432:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80043f:	01 d0                	add    %edx,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800445:	ff 45 e4             	incl   -0x1c(%ebp)
  800448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80044e:	0f 8e ea fe ff ff    	jle    80033e <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  800454:	83 ec 0c             	sub    $0xc,%esp
  800457:	ff 75 d8             	pushl  -0x28(%ebp)
  80045a:	e8 7f 12 00 00       	call   8016de <free>
  80045f:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800462:	83 ec 0c             	sub    $0xc,%esp
  800465:	ff 75 d4             	pushl  -0x2c(%ebp)
  800468:	e8 71 12 00 00       	call   8016de <free>
  80046d:	83 c4 10             	add    $0x10,%esp

}
  800470:	90                   	nop
  800471:	c9                   	leave  
  800472:	c3                   	ret    

00800473 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800473:	55                   	push   %ebp
  800474:	89 e5                	mov    %esp,%ebp
  800476:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800479:	e8 6b 14 00 00       	call   8018e9 <sys_getenvindex>
  80047e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800481:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800484:	89 d0                	mov    %edx,%eax
  800486:	c1 e0 03             	shl    $0x3,%eax
  800489:	01 d0                	add    %edx,%eax
  80048b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800492:	01 c8                	add    %ecx,%eax
  800494:	01 c0                	add    %eax,%eax
  800496:	01 d0                	add    %edx,%eax
  800498:	01 c0                	add    %eax,%eax
  80049a:	01 d0                	add    %edx,%eax
  80049c:	89 c2                	mov    %eax,%edx
  80049e:	c1 e2 05             	shl    $0x5,%edx
  8004a1:	29 c2                	sub    %eax,%edx
  8004a3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8004aa:	89 c2                	mov    %eax,%edx
  8004ac:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8004b2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8004b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bc:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8004c2:	84 c0                	test   %al,%al
  8004c4:	74 0f                	je     8004d5 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8004c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cb:	05 40 3c 01 00       	add    $0x13c40,%eax
  8004d0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004d9:	7e 0a                	jle    8004e5 <libmain+0x72>
		binaryname = argv[0];
  8004db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004de:	8b 00                	mov    (%eax),%eax
  8004e0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004e5:	83 ec 08             	sub    $0x8,%esp
  8004e8:	ff 75 0c             	pushl  0xc(%ebp)
  8004eb:	ff 75 08             	pushl  0x8(%ebp)
  8004ee:	e8 45 fb ff ff       	call   800038 <_main>
  8004f3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004f6:	e8 89 15 00 00       	call   801a84 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004fb:	83 ec 0c             	sub    $0xc,%esp
  8004fe:	68 48 23 80 00       	push   $0x802348
  800503:	e8 84 01 00 00       	call   80068c <cprintf>
  800508:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80050b:	a1 20 30 80 00       	mov    0x803020,%eax
  800510:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800516:	a1 20 30 80 00       	mov    0x803020,%eax
  80051b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800521:	83 ec 04             	sub    $0x4,%esp
  800524:	52                   	push   %edx
  800525:	50                   	push   %eax
  800526:	68 70 23 80 00       	push   $0x802370
  80052b:	e8 5c 01 00 00       	call   80068c <cprintf>
  800530:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800533:	a1 20 30 80 00       	mov    0x803020,%eax
  800538:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80053e:	a1 20 30 80 00       	mov    0x803020,%eax
  800543:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800549:	83 ec 04             	sub    $0x4,%esp
  80054c:	52                   	push   %edx
  80054d:	50                   	push   %eax
  80054e:	68 98 23 80 00       	push   $0x802398
  800553:	e8 34 01 00 00       	call   80068c <cprintf>
  800558:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80055b:	a1 20 30 80 00       	mov    0x803020,%eax
  800560:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800566:	83 ec 08             	sub    $0x8,%esp
  800569:	50                   	push   %eax
  80056a:	68 d9 23 80 00       	push   $0x8023d9
  80056f:	e8 18 01 00 00       	call   80068c <cprintf>
  800574:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800577:	83 ec 0c             	sub    $0xc,%esp
  80057a:	68 48 23 80 00       	push   $0x802348
  80057f:	e8 08 01 00 00       	call   80068c <cprintf>
  800584:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800587:	e8 12 15 00 00       	call   801a9e <sys_enable_interrupt>

	// exit gracefully
	exit();
  80058c:	e8 19 00 00 00       	call   8005aa <exit>
}
  800591:	90                   	nop
  800592:	c9                   	leave  
  800593:	c3                   	ret    

00800594 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800594:	55                   	push   %ebp
  800595:	89 e5                	mov    %esp,%ebp
  800597:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80059a:	83 ec 0c             	sub    $0xc,%esp
  80059d:	6a 00                	push   $0x0
  80059f:	e8 11 13 00 00       	call   8018b5 <sys_env_destroy>
  8005a4:	83 c4 10             	add    $0x10,%esp
}
  8005a7:	90                   	nop
  8005a8:	c9                   	leave  
  8005a9:	c3                   	ret    

008005aa <exit>:

void
exit(void)
{
  8005aa:	55                   	push   %ebp
  8005ab:	89 e5                	mov    %esp,%ebp
  8005ad:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8005b0:	e8 66 13 00 00       	call   80191b <sys_env_exit>
}
  8005b5:	90                   	nop
  8005b6:	c9                   	leave  
  8005b7:	c3                   	ret    

008005b8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005b8:	55                   	push   %ebp
  8005b9:	89 e5                	mov    %esp,%ebp
  8005bb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c1:	8b 00                	mov    (%eax),%eax
  8005c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8005c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c9:	89 0a                	mov    %ecx,(%edx)
  8005cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8005ce:	88 d1                	mov    %dl,%cl
  8005d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	8b 00                	mov    (%eax),%eax
  8005dc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005e1:	75 2c                	jne    80060f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005e3:	a0 24 30 80 00       	mov    0x803024,%al
  8005e8:	0f b6 c0             	movzbl %al,%eax
  8005eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ee:	8b 12                	mov    (%edx),%edx
  8005f0:	89 d1                	mov    %edx,%ecx
  8005f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f5:	83 c2 08             	add    $0x8,%edx
  8005f8:	83 ec 04             	sub    $0x4,%esp
  8005fb:	50                   	push   %eax
  8005fc:	51                   	push   %ecx
  8005fd:	52                   	push   %edx
  8005fe:	e8 70 12 00 00       	call   801873 <sys_cputs>
  800603:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800606:	8b 45 0c             	mov    0xc(%ebp),%eax
  800609:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80060f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800612:	8b 40 04             	mov    0x4(%eax),%eax
  800615:	8d 50 01             	lea    0x1(%eax),%edx
  800618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80061e:	90                   	nop
  80061f:	c9                   	leave  
  800620:	c3                   	ret    

00800621 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800621:	55                   	push   %ebp
  800622:	89 e5                	mov    %esp,%ebp
  800624:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80062a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800631:	00 00 00 
	b.cnt = 0;
  800634:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80063b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80063e:	ff 75 0c             	pushl  0xc(%ebp)
  800641:	ff 75 08             	pushl  0x8(%ebp)
  800644:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80064a:	50                   	push   %eax
  80064b:	68 b8 05 80 00       	push   $0x8005b8
  800650:	e8 11 02 00 00       	call   800866 <vprintfmt>
  800655:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800658:	a0 24 30 80 00       	mov    0x803024,%al
  80065d:	0f b6 c0             	movzbl %al,%eax
  800660:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800666:	83 ec 04             	sub    $0x4,%esp
  800669:	50                   	push   %eax
  80066a:	52                   	push   %edx
  80066b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800671:	83 c0 08             	add    $0x8,%eax
  800674:	50                   	push   %eax
  800675:	e8 f9 11 00 00       	call   801873 <sys_cputs>
  80067a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80067d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800684:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80068a:	c9                   	leave  
  80068b:	c3                   	ret    

0080068c <cprintf>:

int cprintf(const char *fmt, ...) {
  80068c:	55                   	push   %ebp
  80068d:	89 e5                	mov    %esp,%ebp
  80068f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800692:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800699:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	83 ec 08             	sub    $0x8,%esp
  8006a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8006a8:	50                   	push   %eax
  8006a9:	e8 73 ff ff ff       	call   800621 <vcprintf>
  8006ae:	83 c4 10             	add    $0x10,%esp
  8006b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006b7:	c9                   	leave  
  8006b8:	c3                   	ret    

008006b9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006b9:	55                   	push   %ebp
  8006ba:	89 e5                	mov    %esp,%ebp
  8006bc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006bf:	e8 c0 13 00 00       	call   801a84 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8006d3:	50                   	push   %eax
  8006d4:	e8 48 ff ff ff       	call   800621 <vcprintf>
  8006d9:	83 c4 10             	add    $0x10,%esp
  8006dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006df:	e8 ba 13 00 00       	call   801a9e <sys_enable_interrupt>
	return cnt;
  8006e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006e7:	c9                   	leave  
  8006e8:	c3                   	ret    

008006e9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006e9:	55                   	push   %ebp
  8006ea:	89 e5                	mov    %esp,%ebp
  8006ec:	53                   	push   %ebx
  8006ed:	83 ec 14             	sub    $0x14,%esp
  8006f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8006ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800704:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800707:	77 55                	ja     80075e <printnum+0x75>
  800709:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80070c:	72 05                	jb     800713 <printnum+0x2a>
  80070e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800711:	77 4b                	ja     80075e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800713:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800716:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800719:	8b 45 18             	mov    0x18(%ebp),%eax
  80071c:	ba 00 00 00 00       	mov    $0x0,%edx
  800721:	52                   	push   %edx
  800722:	50                   	push   %eax
  800723:	ff 75 f4             	pushl  -0xc(%ebp)
  800726:	ff 75 f0             	pushl  -0x10(%ebp)
  800729:	e8 46 19 00 00       	call   802074 <__udivdi3>
  80072e:	83 c4 10             	add    $0x10,%esp
  800731:	83 ec 04             	sub    $0x4,%esp
  800734:	ff 75 20             	pushl  0x20(%ebp)
  800737:	53                   	push   %ebx
  800738:	ff 75 18             	pushl  0x18(%ebp)
  80073b:	52                   	push   %edx
  80073c:	50                   	push   %eax
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	ff 75 08             	pushl  0x8(%ebp)
  800743:	e8 a1 ff ff ff       	call   8006e9 <printnum>
  800748:	83 c4 20             	add    $0x20,%esp
  80074b:	eb 1a                	jmp    800767 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80074d:	83 ec 08             	sub    $0x8,%esp
  800750:	ff 75 0c             	pushl  0xc(%ebp)
  800753:	ff 75 20             	pushl  0x20(%ebp)
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	ff d0                	call   *%eax
  80075b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80075e:	ff 4d 1c             	decl   0x1c(%ebp)
  800761:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800765:	7f e6                	jg     80074d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800767:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80076a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80076f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800772:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800775:	53                   	push   %ebx
  800776:	51                   	push   %ecx
  800777:	52                   	push   %edx
  800778:	50                   	push   %eax
  800779:	e8 06 1a 00 00       	call   802184 <__umoddi3>
  80077e:	83 c4 10             	add    $0x10,%esp
  800781:	05 14 26 80 00       	add    $0x802614,%eax
  800786:	8a 00                	mov    (%eax),%al
  800788:	0f be c0             	movsbl %al,%eax
  80078b:	83 ec 08             	sub    $0x8,%esp
  80078e:	ff 75 0c             	pushl  0xc(%ebp)
  800791:	50                   	push   %eax
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	ff d0                	call   *%eax
  800797:	83 c4 10             	add    $0x10,%esp
}
  80079a:	90                   	nop
  80079b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80079e:	c9                   	leave  
  80079f:	c3                   	ret    

008007a0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007a0:	55                   	push   %ebp
  8007a1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007a7:	7e 1c                	jle    8007c5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	8b 00                	mov    (%eax),%eax
  8007ae:	8d 50 08             	lea    0x8(%eax),%edx
  8007b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b4:	89 10                	mov    %edx,(%eax)
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	83 e8 08             	sub    $0x8,%eax
  8007be:	8b 50 04             	mov    0x4(%eax),%edx
  8007c1:	8b 00                	mov    (%eax),%eax
  8007c3:	eb 40                	jmp    800805 <getuint+0x65>
	else if (lflag)
  8007c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007c9:	74 1e                	je     8007e9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	8b 00                	mov    (%eax),%eax
  8007d0:	8d 50 04             	lea    0x4(%eax),%edx
  8007d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d6:	89 10                	mov    %edx,(%eax)
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	83 e8 04             	sub    $0x4,%eax
  8007e0:	8b 00                	mov    (%eax),%eax
  8007e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8007e7:	eb 1c                	jmp    800805 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	8b 00                	mov    (%eax),%eax
  8007ee:	8d 50 04             	lea    0x4(%eax),%edx
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	89 10                	mov    %edx,(%eax)
  8007f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	83 e8 04             	sub    $0x4,%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800805:	5d                   	pop    %ebp
  800806:	c3                   	ret    

00800807 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800807:	55                   	push   %ebp
  800808:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80080a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80080e:	7e 1c                	jle    80082c <getint+0x25>
		return va_arg(*ap, long long);
  800810:	8b 45 08             	mov    0x8(%ebp),%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	8d 50 08             	lea    0x8(%eax),%edx
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	89 10                	mov    %edx,(%eax)
  80081d:	8b 45 08             	mov    0x8(%ebp),%eax
  800820:	8b 00                	mov    (%eax),%eax
  800822:	83 e8 08             	sub    $0x8,%eax
  800825:	8b 50 04             	mov    0x4(%eax),%edx
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	eb 38                	jmp    800864 <getint+0x5d>
	else if (lflag)
  80082c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800830:	74 1a                	je     80084c <getint+0x45>
		return va_arg(*ap, long);
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	8d 50 04             	lea    0x4(%eax),%edx
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	89 10                	mov    %edx,(%eax)
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	8b 00                	mov    (%eax),%eax
  800844:	83 e8 04             	sub    $0x4,%eax
  800847:	8b 00                	mov    (%eax),%eax
  800849:	99                   	cltd   
  80084a:	eb 18                	jmp    800864 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	8d 50 04             	lea    0x4(%eax),%edx
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	89 10                	mov    %edx,(%eax)
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	83 e8 04             	sub    $0x4,%eax
  800861:	8b 00                	mov    (%eax),%eax
  800863:	99                   	cltd   
}
  800864:	5d                   	pop    %ebp
  800865:	c3                   	ret    

00800866 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800866:	55                   	push   %ebp
  800867:	89 e5                	mov    %esp,%ebp
  800869:	56                   	push   %esi
  80086a:	53                   	push   %ebx
  80086b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80086e:	eb 17                	jmp    800887 <vprintfmt+0x21>
			if (ch == '\0')
  800870:	85 db                	test   %ebx,%ebx
  800872:	0f 84 af 03 00 00    	je     800c27 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800878:	83 ec 08             	sub    $0x8,%esp
  80087b:	ff 75 0c             	pushl  0xc(%ebp)
  80087e:	53                   	push   %ebx
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	ff d0                	call   *%eax
  800884:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800887:	8b 45 10             	mov    0x10(%ebp),%eax
  80088a:	8d 50 01             	lea    0x1(%eax),%edx
  80088d:	89 55 10             	mov    %edx,0x10(%ebp)
  800890:	8a 00                	mov    (%eax),%al
  800892:	0f b6 d8             	movzbl %al,%ebx
  800895:	83 fb 25             	cmp    $0x25,%ebx
  800898:	75 d6                	jne    800870 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80089a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80089e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008a5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008ac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008b3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bd:	8d 50 01             	lea    0x1(%eax),%edx
  8008c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8008c3:	8a 00                	mov    (%eax),%al
  8008c5:	0f b6 d8             	movzbl %al,%ebx
  8008c8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008cb:	83 f8 55             	cmp    $0x55,%eax
  8008ce:	0f 87 2b 03 00 00    	ja     800bff <vprintfmt+0x399>
  8008d4:	8b 04 85 38 26 80 00 	mov    0x802638(,%eax,4),%eax
  8008db:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008dd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008e1:	eb d7                	jmp    8008ba <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008e3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008e7:	eb d1                	jmp    8008ba <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008e9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008f0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f3:	89 d0                	mov    %edx,%eax
  8008f5:	c1 e0 02             	shl    $0x2,%eax
  8008f8:	01 d0                	add    %edx,%eax
  8008fa:	01 c0                	add    %eax,%eax
  8008fc:	01 d8                	add    %ebx,%eax
  8008fe:	83 e8 30             	sub    $0x30,%eax
  800901:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800904:	8b 45 10             	mov    0x10(%ebp),%eax
  800907:	8a 00                	mov    (%eax),%al
  800909:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80090c:	83 fb 2f             	cmp    $0x2f,%ebx
  80090f:	7e 3e                	jle    80094f <vprintfmt+0xe9>
  800911:	83 fb 39             	cmp    $0x39,%ebx
  800914:	7f 39                	jg     80094f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800916:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800919:	eb d5                	jmp    8008f0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80091b:	8b 45 14             	mov    0x14(%ebp),%eax
  80091e:	83 c0 04             	add    $0x4,%eax
  800921:	89 45 14             	mov    %eax,0x14(%ebp)
  800924:	8b 45 14             	mov    0x14(%ebp),%eax
  800927:	83 e8 04             	sub    $0x4,%eax
  80092a:	8b 00                	mov    (%eax),%eax
  80092c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80092f:	eb 1f                	jmp    800950 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800931:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800935:	79 83                	jns    8008ba <vprintfmt+0x54>
				width = 0;
  800937:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80093e:	e9 77 ff ff ff       	jmp    8008ba <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800943:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80094a:	e9 6b ff ff ff       	jmp    8008ba <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80094f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800950:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800954:	0f 89 60 ff ff ff    	jns    8008ba <vprintfmt+0x54>
				width = precision, precision = -1;
  80095a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80095d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800960:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800967:	e9 4e ff ff ff       	jmp    8008ba <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80096c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80096f:	e9 46 ff ff ff       	jmp    8008ba <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800974:	8b 45 14             	mov    0x14(%ebp),%eax
  800977:	83 c0 04             	add    $0x4,%eax
  80097a:	89 45 14             	mov    %eax,0x14(%ebp)
  80097d:	8b 45 14             	mov    0x14(%ebp),%eax
  800980:	83 e8 04             	sub    $0x4,%eax
  800983:	8b 00                	mov    (%eax),%eax
  800985:	83 ec 08             	sub    $0x8,%esp
  800988:	ff 75 0c             	pushl  0xc(%ebp)
  80098b:	50                   	push   %eax
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	ff d0                	call   *%eax
  800991:	83 c4 10             	add    $0x10,%esp
			break;
  800994:	e9 89 02 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800999:	8b 45 14             	mov    0x14(%ebp),%eax
  80099c:	83 c0 04             	add    $0x4,%eax
  80099f:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a5:	83 e8 04             	sub    $0x4,%eax
  8009a8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009aa:	85 db                	test   %ebx,%ebx
  8009ac:	79 02                	jns    8009b0 <vprintfmt+0x14a>
				err = -err;
  8009ae:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009b0:	83 fb 64             	cmp    $0x64,%ebx
  8009b3:	7f 0b                	jg     8009c0 <vprintfmt+0x15a>
  8009b5:	8b 34 9d 80 24 80 00 	mov    0x802480(,%ebx,4),%esi
  8009bc:	85 f6                	test   %esi,%esi
  8009be:	75 19                	jne    8009d9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009c0:	53                   	push   %ebx
  8009c1:	68 25 26 80 00       	push   $0x802625
  8009c6:	ff 75 0c             	pushl  0xc(%ebp)
  8009c9:	ff 75 08             	pushl  0x8(%ebp)
  8009cc:	e8 5e 02 00 00       	call   800c2f <printfmt>
  8009d1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009d4:	e9 49 02 00 00       	jmp    800c22 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009d9:	56                   	push   %esi
  8009da:	68 2e 26 80 00       	push   $0x80262e
  8009df:	ff 75 0c             	pushl  0xc(%ebp)
  8009e2:	ff 75 08             	pushl  0x8(%ebp)
  8009e5:	e8 45 02 00 00       	call   800c2f <printfmt>
  8009ea:	83 c4 10             	add    $0x10,%esp
			break;
  8009ed:	e9 30 02 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f5:	83 c0 04             	add    $0x4,%eax
  8009f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fe:	83 e8 04             	sub    $0x4,%eax
  800a01:	8b 30                	mov    (%eax),%esi
  800a03:	85 f6                	test   %esi,%esi
  800a05:	75 05                	jne    800a0c <vprintfmt+0x1a6>
				p = "(null)";
  800a07:	be 31 26 80 00       	mov    $0x802631,%esi
			if (width > 0 && padc != '-')
  800a0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a10:	7e 6d                	jle    800a7f <vprintfmt+0x219>
  800a12:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a16:	74 67                	je     800a7f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a1b:	83 ec 08             	sub    $0x8,%esp
  800a1e:	50                   	push   %eax
  800a1f:	56                   	push   %esi
  800a20:	e8 0c 03 00 00       	call   800d31 <strnlen>
  800a25:	83 c4 10             	add    $0x10,%esp
  800a28:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a2b:	eb 16                	jmp    800a43 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a2d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a31:	83 ec 08             	sub    $0x8,%esp
  800a34:	ff 75 0c             	pushl  0xc(%ebp)
  800a37:	50                   	push   %eax
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	ff d0                	call   *%eax
  800a3d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a40:	ff 4d e4             	decl   -0x1c(%ebp)
  800a43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a47:	7f e4                	jg     800a2d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a49:	eb 34                	jmp    800a7f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a4b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a4f:	74 1c                	je     800a6d <vprintfmt+0x207>
  800a51:	83 fb 1f             	cmp    $0x1f,%ebx
  800a54:	7e 05                	jle    800a5b <vprintfmt+0x1f5>
  800a56:	83 fb 7e             	cmp    $0x7e,%ebx
  800a59:	7e 12                	jle    800a6d <vprintfmt+0x207>
					putch('?', putdat);
  800a5b:	83 ec 08             	sub    $0x8,%esp
  800a5e:	ff 75 0c             	pushl  0xc(%ebp)
  800a61:	6a 3f                	push   $0x3f
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
  800a6b:	eb 0f                	jmp    800a7c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	ff 75 0c             	pushl  0xc(%ebp)
  800a73:	53                   	push   %ebx
  800a74:	8b 45 08             	mov    0x8(%ebp),%eax
  800a77:	ff d0                	call   *%eax
  800a79:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a7c:	ff 4d e4             	decl   -0x1c(%ebp)
  800a7f:	89 f0                	mov    %esi,%eax
  800a81:	8d 70 01             	lea    0x1(%eax),%esi
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	0f be d8             	movsbl %al,%ebx
  800a89:	85 db                	test   %ebx,%ebx
  800a8b:	74 24                	je     800ab1 <vprintfmt+0x24b>
  800a8d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a91:	78 b8                	js     800a4b <vprintfmt+0x1e5>
  800a93:	ff 4d e0             	decl   -0x20(%ebp)
  800a96:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a9a:	79 af                	jns    800a4b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a9c:	eb 13                	jmp    800ab1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a9e:	83 ec 08             	sub    $0x8,%esp
  800aa1:	ff 75 0c             	pushl  0xc(%ebp)
  800aa4:	6a 20                	push   $0x20
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	ff d0                	call   *%eax
  800aab:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aae:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab5:	7f e7                	jg     800a9e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ab7:	e9 66 01 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800abc:	83 ec 08             	sub    $0x8,%esp
  800abf:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac5:	50                   	push   %eax
  800ac6:	e8 3c fd ff ff       	call   800807 <getint>
  800acb:	83 c4 10             	add    $0x10,%esp
  800ace:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ad4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ada:	85 d2                	test   %edx,%edx
  800adc:	79 23                	jns    800b01 <vprintfmt+0x29b>
				putch('-', putdat);
  800ade:	83 ec 08             	sub    $0x8,%esp
  800ae1:	ff 75 0c             	pushl  0xc(%ebp)
  800ae4:	6a 2d                	push   $0x2d
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	ff d0                	call   *%eax
  800aeb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800aee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af4:	f7 d8                	neg    %eax
  800af6:	83 d2 00             	adc    $0x0,%edx
  800af9:	f7 da                	neg    %edx
  800afb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800afe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b08:	e9 bc 00 00 00       	jmp    800bc9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 e8             	pushl  -0x18(%ebp)
  800b13:	8d 45 14             	lea    0x14(%ebp),%eax
  800b16:	50                   	push   %eax
  800b17:	e8 84 fc ff ff       	call   8007a0 <getuint>
  800b1c:	83 c4 10             	add    $0x10,%esp
  800b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b2c:	e9 98 00 00 00       	jmp    800bc9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b31:	83 ec 08             	sub    $0x8,%esp
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	6a 58                	push   $0x58
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	ff d0                	call   *%eax
  800b3e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	6a 58                	push   $0x58
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	ff d0                	call   *%eax
  800b4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b51:	83 ec 08             	sub    $0x8,%esp
  800b54:	ff 75 0c             	pushl  0xc(%ebp)
  800b57:	6a 58                	push   $0x58
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	ff d0                	call   *%eax
  800b5e:	83 c4 10             	add    $0x10,%esp
			break;
  800b61:	e9 bc 00 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b66:	83 ec 08             	sub    $0x8,%esp
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	6a 30                	push   $0x30
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b76:	83 ec 08             	sub    $0x8,%esp
  800b79:	ff 75 0c             	pushl  0xc(%ebp)
  800b7c:	6a 78                	push   $0x78
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	ff d0                	call   *%eax
  800b83:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b86:	8b 45 14             	mov    0x14(%ebp),%eax
  800b89:	83 c0 04             	add    $0x4,%eax
  800b8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b92:	83 e8 04             	sub    $0x4,%eax
  800b95:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ba1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ba8:	eb 1f                	jmp    800bc9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800baa:	83 ec 08             	sub    $0x8,%esp
  800bad:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb0:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb3:	50                   	push   %eax
  800bb4:	e8 e7 fb ff ff       	call   8007a0 <getuint>
  800bb9:	83 c4 10             	add    $0x10,%esp
  800bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bc2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bc9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bcd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd0:	83 ec 04             	sub    $0x4,%esp
  800bd3:	52                   	push   %edx
  800bd4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bd7:	50                   	push   %eax
  800bd8:	ff 75 f4             	pushl  -0xc(%ebp)
  800bdb:	ff 75 f0             	pushl  -0x10(%ebp)
  800bde:	ff 75 0c             	pushl  0xc(%ebp)
  800be1:	ff 75 08             	pushl  0x8(%ebp)
  800be4:	e8 00 fb ff ff       	call   8006e9 <printnum>
  800be9:	83 c4 20             	add    $0x20,%esp
			break;
  800bec:	eb 34                	jmp    800c22 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bee:	83 ec 08             	sub    $0x8,%esp
  800bf1:	ff 75 0c             	pushl  0xc(%ebp)
  800bf4:	53                   	push   %ebx
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	ff d0                	call   *%eax
  800bfa:	83 c4 10             	add    $0x10,%esp
			break;
  800bfd:	eb 23                	jmp    800c22 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	6a 25                	push   $0x25
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	ff d0                	call   *%eax
  800c0c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c0f:	ff 4d 10             	decl   0x10(%ebp)
  800c12:	eb 03                	jmp    800c17 <vprintfmt+0x3b1>
  800c14:	ff 4d 10             	decl   0x10(%ebp)
  800c17:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1a:	48                   	dec    %eax
  800c1b:	8a 00                	mov    (%eax),%al
  800c1d:	3c 25                	cmp    $0x25,%al
  800c1f:	75 f3                	jne    800c14 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c21:	90                   	nop
		}
	}
  800c22:	e9 47 fc ff ff       	jmp    80086e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c27:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c28:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c2b:	5b                   	pop    %ebx
  800c2c:	5e                   	pop    %esi
  800c2d:	5d                   	pop    %ebp
  800c2e:	c3                   	ret    

00800c2f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c35:	8d 45 10             	lea    0x10(%ebp),%eax
  800c38:	83 c0 04             	add    $0x4,%eax
  800c3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c41:	ff 75 f4             	pushl  -0xc(%ebp)
  800c44:	50                   	push   %eax
  800c45:	ff 75 0c             	pushl  0xc(%ebp)
  800c48:	ff 75 08             	pushl  0x8(%ebp)
  800c4b:	e8 16 fc ff ff       	call   800866 <vprintfmt>
  800c50:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c53:	90                   	nop
  800c54:	c9                   	leave  
  800c55:	c3                   	ret    

00800c56 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5c:	8b 40 08             	mov    0x8(%eax),%eax
  800c5f:	8d 50 01             	lea    0x1(%eax),%edx
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6b:	8b 10                	mov    (%eax),%edx
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	8b 40 04             	mov    0x4(%eax),%eax
  800c73:	39 c2                	cmp    %eax,%edx
  800c75:	73 12                	jae    800c89 <sprintputch+0x33>
		*b->buf++ = ch;
  800c77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7a:	8b 00                	mov    (%eax),%eax
  800c7c:	8d 48 01             	lea    0x1(%eax),%ecx
  800c7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c82:	89 0a                	mov    %ecx,(%edx)
  800c84:	8b 55 08             	mov    0x8(%ebp),%edx
  800c87:	88 10                	mov    %dl,(%eax)
}
  800c89:	90                   	nop
  800c8a:	5d                   	pop    %ebp
  800c8b:	c3                   	ret    

00800c8c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
  800c8f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	01 d0                	add    %edx,%eax
  800ca3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cb1:	74 06                	je     800cb9 <vsnprintf+0x2d>
  800cb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb7:	7f 07                	jg     800cc0 <vsnprintf+0x34>
		return -E_INVAL;
  800cb9:	b8 03 00 00 00       	mov    $0x3,%eax
  800cbe:	eb 20                	jmp    800ce0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cc0:	ff 75 14             	pushl  0x14(%ebp)
  800cc3:	ff 75 10             	pushl  0x10(%ebp)
  800cc6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cc9:	50                   	push   %eax
  800cca:	68 56 0c 80 00       	push   $0x800c56
  800ccf:	e8 92 fb ff ff       	call   800866 <vprintfmt>
  800cd4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cda:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ce0:	c9                   	leave  
  800ce1:	c3                   	ret    

00800ce2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ce2:	55                   	push   %ebp
  800ce3:	89 e5                	mov    %esp,%ebp
  800ce5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ce8:	8d 45 10             	lea    0x10(%ebp),%eax
  800ceb:	83 c0 04             	add    $0x4,%eax
  800cee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cf1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf7:	50                   	push   %eax
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	ff 75 08             	pushl  0x8(%ebp)
  800cfe:	e8 89 ff ff ff       	call   800c8c <vsnprintf>
  800d03:	83 c4 10             	add    $0x10,%esp
  800d06:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d09:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d0c:	c9                   	leave  
  800d0d:	c3                   	ret    

00800d0e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d0e:	55                   	push   %ebp
  800d0f:	89 e5                	mov    %esp,%ebp
  800d11:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1b:	eb 06                	jmp    800d23 <strlen+0x15>
		n++;
  800d1d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 f1                	jne    800d1d <strlen+0xf>
		n++;
	return n;
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3e:	eb 09                	jmp    800d49 <strnlen+0x18>
		n++;
  800d40:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d43:	ff 45 08             	incl   0x8(%ebp)
  800d46:	ff 4d 0c             	decl   0xc(%ebp)
  800d49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d4d:	74 09                	je     800d58 <strnlen+0x27>
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	84 c0                	test   %al,%al
  800d56:	75 e8                	jne    800d40 <strnlen+0xf>
		n++;
	return n;
  800d58:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5b:	c9                   	leave  
  800d5c:	c3                   	ret    

00800d5d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d5d:	55                   	push   %ebp
  800d5e:	89 e5                	mov    %esp,%ebp
  800d60:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d69:	90                   	nop
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8d 50 01             	lea    0x1(%eax),%edx
  800d70:	89 55 08             	mov    %edx,0x8(%ebp)
  800d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d76:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d79:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d7c:	8a 12                	mov    (%edx),%dl
  800d7e:	88 10                	mov    %dl,(%eax)
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	84 c0                	test   %al,%al
  800d84:	75 e4                	jne    800d6a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d89:	c9                   	leave  
  800d8a:	c3                   	ret    

00800d8b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d8b:	55                   	push   %ebp
  800d8c:	89 e5                	mov    %esp,%ebp
  800d8e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d9e:	eb 1f                	jmp    800dbf <strncpy+0x34>
		*dst++ = *src;
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8d 50 01             	lea    0x1(%eax),%edx
  800da6:	89 55 08             	mov    %edx,0x8(%ebp)
  800da9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dac:	8a 12                	mov    (%edx),%dl
  800dae:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800db0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	84 c0                	test   %al,%al
  800db7:	74 03                	je     800dbc <strncpy+0x31>
			src++;
  800db9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dbc:	ff 45 fc             	incl   -0x4(%ebp)
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc5:	72 d9                	jb     800da0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddc:	74 30                	je     800e0e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dde:	eb 16                	jmp    800df6 <strlcpy+0x2a>
			*dst++ = *src++;
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8d 50 01             	lea    0x1(%eax),%edx
  800de6:	89 55 08             	mov    %edx,0x8(%ebp)
  800de9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800def:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df2:	8a 12                	mov    (%edx),%dl
  800df4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800df6:	ff 4d 10             	decl   0x10(%ebp)
  800df9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfd:	74 09                	je     800e08 <strlcpy+0x3c>
  800dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e02:	8a 00                	mov    (%eax),%al
  800e04:	84 c0                	test   %al,%al
  800e06:	75 d8                	jne    800de0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e0e:	8b 55 08             	mov    0x8(%ebp),%edx
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	29 c2                	sub    %eax,%edx
  800e16:	89 d0                	mov    %edx,%eax
}
  800e18:	c9                   	leave  
  800e19:	c3                   	ret    

00800e1a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e1a:	55                   	push   %ebp
  800e1b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e1d:	eb 06                	jmp    800e25 <strcmp+0xb>
		p++, q++;
  800e1f:	ff 45 08             	incl   0x8(%ebp)
  800e22:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	84 c0                	test   %al,%al
  800e2c:	74 0e                	je     800e3c <strcmp+0x22>
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 10                	mov    (%eax),%dl
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	8a 00                	mov    (%eax),%al
  800e38:	38 c2                	cmp    %al,%dl
  800e3a:	74 e3                	je     800e1f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8a 00                	mov    (%eax),%al
  800e41:	0f b6 d0             	movzbl %al,%edx
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	0f b6 c0             	movzbl %al,%eax
  800e4c:	29 c2                	sub    %eax,%edx
  800e4e:	89 d0                	mov    %edx,%eax
}
  800e50:	5d                   	pop    %ebp
  800e51:	c3                   	ret    

00800e52 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e52:	55                   	push   %ebp
  800e53:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e55:	eb 09                	jmp    800e60 <strncmp+0xe>
		n--, p++, q++;
  800e57:	ff 4d 10             	decl   0x10(%ebp)
  800e5a:	ff 45 08             	incl   0x8(%ebp)
  800e5d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e64:	74 17                	je     800e7d <strncmp+0x2b>
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	8a 00                	mov    (%eax),%al
  800e6b:	84 c0                	test   %al,%al
  800e6d:	74 0e                	je     800e7d <strncmp+0x2b>
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8a 10                	mov    (%eax),%dl
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	38 c2                	cmp    %al,%dl
  800e7b:	74 da                	je     800e57 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e81:	75 07                	jne    800e8a <strncmp+0x38>
		return 0;
  800e83:	b8 00 00 00 00       	mov    $0x0,%eax
  800e88:	eb 14                	jmp    800e9e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f b6 d0             	movzbl %al,%edx
  800e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	0f b6 c0             	movzbl %al,%eax
  800e9a:	29 c2                	sub    %eax,%edx
  800e9c:	89 d0                	mov    %edx,%eax
}
  800e9e:	5d                   	pop    %ebp
  800e9f:	c3                   	ret    

00800ea0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 04             	sub    $0x4,%esp
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eac:	eb 12                	jmp    800ec0 <strchr+0x20>
		if (*s == c)
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eb6:	75 05                	jne    800ebd <strchr+0x1d>
			return (char *) s;
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	eb 11                	jmp    800ece <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ebd:	ff 45 08             	incl   0x8(%ebp)
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	84 c0                	test   %al,%al
  800ec7:	75 e5                	jne    800eae <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ec9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ece:	c9                   	leave  
  800ecf:	c3                   	ret    

00800ed0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ed0:	55                   	push   %ebp
  800ed1:	89 e5                	mov    %esp,%ebp
  800ed3:	83 ec 04             	sub    $0x4,%esp
  800ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800edc:	eb 0d                	jmp    800eeb <strfind+0x1b>
		if (*s == c)
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ee6:	74 0e                	je     800ef6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	84 c0                	test   %al,%al
  800ef2:	75 ea                	jne    800ede <strfind+0xe>
  800ef4:	eb 01                	jmp    800ef7 <strfind+0x27>
		if (*s == c)
			break;
  800ef6:	90                   	nop
	return (char *) s;
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efa:	c9                   	leave  
  800efb:	c3                   	ret    

00800efc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f08:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f0e:	eb 0e                	jmp    800f1e <memset+0x22>
		*p++ = c;
  800f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f13:	8d 50 01             	lea    0x1(%eax),%edx
  800f16:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f1e:	ff 4d f8             	decl   -0x8(%ebp)
  800f21:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f25:	79 e9                	jns    800f10 <memset+0x14>
		*p++ = c;

	return v;
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f2a:	c9                   	leave  
  800f2b:	c3                   	ret    

00800f2c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f2c:	55                   	push   %ebp
  800f2d:	89 e5                	mov    %esp,%ebp
  800f2f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f3e:	eb 16                	jmp    800f56 <memcpy+0x2a>
		*d++ = *s++;
  800f40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f43:	8d 50 01             	lea    0x1(%eax),%edx
  800f46:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f49:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f4c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f4f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f52:	8a 12                	mov    (%edx),%dl
  800f54:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f56:	8b 45 10             	mov    0x10(%ebp),%eax
  800f59:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f5c:	89 55 10             	mov    %edx,0x10(%ebp)
  800f5f:	85 c0                	test   %eax,%eax
  800f61:	75 dd                	jne    800f40 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f66:	c9                   	leave  
  800f67:	c3                   	ret    

00800f68 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f68:	55                   	push   %ebp
  800f69:	89 e5                	mov    %esp,%ebp
  800f6b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f80:	73 50                	jae    800fd2 <memmove+0x6a>
  800f82:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f85:	8b 45 10             	mov    0x10(%ebp),%eax
  800f88:	01 d0                	add    %edx,%eax
  800f8a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f8d:	76 43                	jbe    800fd2 <memmove+0x6a>
		s += n;
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f95:	8b 45 10             	mov    0x10(%ebp),%eax
  800f98:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f9b:	eb 10                	jmp    800fad <memmove+0x45>
			*--d = *--s;
  800f9d:	ff 4d f8             	decl   -0x8(%ebp)
  800fa0:	ff 4d fc             	decl   -0x4(%ebp)
  800fa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa6:	8a 10                	mov    (%eax),%dl
  800fa8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fab:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fad:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb3:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb6:	85 c0                	test   %eax,%eax
  800fb8:	75 e3                	jne    800f9d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fba:	eb 23                	jmp    800fdf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbf:	8d 50 01             	lea    0x1(%eax),%edx
  800fc2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fcb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fce:	8a 12                	mov    (%edx),%dl
  800fd0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800fdb:	85 c0                	test   %eax,%eax
  800fdd:	75 dd                	jne    800fbc <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe2:	c9                   	leave  
  800fe3:	c3                   	ret    

00800fe4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fe4:	55                   	push   %ebp
  800fe5:	89 e5                	mov    %esp,%ebp
  800fe7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ff6:	eb 2a                	jmp    801022 <memcmp+0x3e>
		if (*s1 != *s2)
  800ff8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ffb:	8a 10                	mov    (%eax),%dl
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	38 c2                	cmp    %al,%dl
  801004:	74 16                	je     80101c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801006:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	0f b6 d0             	movzbl %al,%edx
  80100e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	0f b6 c0             	movzbl %al,%eax
  801016:	29 c2                	sub    %eax,%edx
  801018:	89 d0                	mov    %edx,%eax
  80101a:	eb 18                	jmp    801034 <memcmp+0x50>
		s1++, s2++;
  80101c:	ff 45 fc             	incl   -0x4(%ebp)
  80101f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801022:	8b 45 10             	mov    0x10(%ebp),%eax
  801025:	8d 50 ff             	lea    -0x1(%eax),%edx
  801028:	89 55 10             	mov    %edx,0x10(%ebp)
  80102b:	85 c0                	test   %eax,%eax
  80102d:	75 c9                	jne    800ff8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80102f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801034:	c9                   	leave  
  801035:	c3                   	ret    

00801036 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801036:	55                   	push   %ebp
  801037:	89 e5                	mov    %esp,%ebp
  801039:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80103c:	8b 55 08             	mov    0x8(%ebp),%edx
  80103f:	8b 45 10             	mov    0x10(%ebp),%eax
  801042:	01 d0                	add    %edx,%eax
  801044:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801047:	eb 15                	jmp    80105e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	0f b6 d0             	movzbl %al,%edx
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	0f b6 c0             	movzbl %al,%eax
  801057:	39 c2                	cmp    %eax,%edx
  801059:	74 0d                	je     801068 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80105b:	ff 45 08             	incl   0x8(%ebp)
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801064:	72 e3                	jb     801049 <memfind+0x13>
  801066:	eb 01                	jmp    801069 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801068:	90                   	nop
	return (void *) s;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801074:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80107b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801082:	eb 03                	jmp    801087 <strtol+0x19>
		s++;
  801084:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8a 00                	mov    (%eax),%al
  80108c:	3c 20                	cmp    $0x20,%al
  80108e:	74 f4                	je     801084 <strtol+0x16>
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	3c 09                	cmp    $0x9,%al
  801097:	74 eb                	je     801084 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	8a 00                	mov    (%eax),%al
  80109e:	3c 2b                	cmp    $0x2b,%al
  8010a0:	75 05                	jne    8010a7 <strtol+0x39>
		s++;
  8010a2:	ff 45 08             	incl   0x8(%ebp)
  8010a5:	eb 13                	jmp    8010ba <strtol+0x4c>
	else if (*s == '-')
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	8a 00                	mov    (%eax),%al
  8010ac:	3c 2d                	cmp    $0x2d,%al
  8010ae:	75 0a                	jne    8010ba <strtol+0x4c>
		s++, neg = 1;
  8010b0:	ff 45 08             	incl   0x8(%ebp)
  8010b3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010be:	74 06                	je     8010c6 <strtol+0x58>
  8010c0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010c4:	75 20                	jne    8010e6 <strtol+0x78>
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	3c 30                	cmp    $0x30,%al
  8010cd:	75 17                	jne    8010e6 <strtol+0x78>
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	40                   	inc    %eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	3c 78                	cmp    $0x78,%al
  8010d7:	75 0d                	jne    8010e6 <strtol+0x78>
		s += 2, base = 16;
  8010d9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010dd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010e4:	eb 28                	jmp    80110e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ea:	75 15                	jne    801101 <strtol+0x93>
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	3c 30                	cmp    $0x30,%al
  8010f3:	75 0c                	jne    801101 <strtol+0x93>
		s++, base = 8;
  8010f5:	ff 45 08             	incl   0x8(%ebp)
  8010f8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010ff:	eb 0d                	jmp    80110e <strtol+0xa0>
	else if (base == 0)
  801101:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801105:	75 07                	jne    80110e <strtol+0xa0>
		base = 10;
  801107:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 2f                	cmp    $0x2f,%al
  801115:	7e 19                	jle    801130 <strtol+0xc2>
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	3c 39                	cmp    $0x39,%al
  80111e:	7f 10                	jg     801130 <strtol+0xc2>
			dig = *s - '0';
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	0f be c0             	movsbl %al,%eax
  801128:	83 e8 30             	sub    $0x30,%eax
  80112b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80112e:	eb 42                	jmp    801172 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	3c 60                	cmp    $0x60,%al
  801137:	7e 19                	jle    801152 <strtol+0xe4>
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	3c 7a                	cmp    $0x7a,%al
  801140:	7f 10                	jg     801152 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	8a 00                	mov    (%eax),%al
  801147:	0f be c0             	movsbl %al,%eax
  80114a:	83 e8 57             	sub    $0x57,%eax
  80114d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801150:	eb 20                	jmp    801172 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	8a 00                	mov    (%eax),%al
  801157:	3c 40                	cmp    $0x40,%al
  801159:	7e 39                	jle    801194 <strtol+0x126>
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	3c 5a                	cmp    $0x5a,%al
  801162:	7f 30                	jg     801194 <strtol+0x126>
			dig = *s - 'A' + 10;
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	0f be c0             	movsbl %al,%eax
  80116c:	83 e8 37             	sub    $0x37,%eax
  80116f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801172:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801175:	3b 45 10             	cmp    0x10(%ebp),%eax
  801178:	7d 19                	jge    801193 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80117a:	ff 45 08             	incl   0x8(%ebp)
  80117d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801180:	0f af 45 10          	imul   0x10(%ebp),%eax
  801184:	89 c2                	mov    %eax,%edx
  801186:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801189:	01 d0                	add    %edx,%eax
  80118b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80118e:	e9 7b ff ff ff       	jmp    80110e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801193:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801194:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801198:	74 08                	je     8011a2 <strtol+0x134>
		*endptr = (char *) s;
  80119a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119d:	8b 55 08             	mov    0x8(%ebp),%edx
  8011a0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011a6:	74 07                	je     8011af <strtol+0x141>
  8011a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ab:	f7 d8                	neg    %eax
  8011ad:	eb 03                	jmp    8011b2 <strtol+0x144>
  8011af:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <ltostr>:

void
ltostr(long value, char *str)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
  8011b7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011cc:	79 13                	jns    8011e1 <ltostr+0x2d>
	{
		neg = 1;
  8011ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011db:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011de:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011e9:	99                   	cltd   
  8011ea:	f7 f9                	idiv   %ecx
  8011ec:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f2:	8d 50 01             	lea    0x1(%eax),%edx
  8011f5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011f8:	89 c2                	mov    %eax,%edx
  8011fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fd:	01 d0                	add    %edx,%eax
  8011ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801202:	83 c2 30             	add    $0x30,%edx
  801205:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801207:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80120a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80120f:	f7 e9                	imul   %ecx
  801211:	c1 fa 02             	sar    $0x2,%edx
  801214:	89 c8                	mov    %ecx,%eax
  801216:	c1 f8 1f             	sar    $0x1f,%eax
  801219:	29 c2                	sub    %eax,%edx
  80121b:	89 d0                	mov    %edx,%eax
  80121d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801220:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801223:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801228:	f7 e9                	imul   %ecx
  80122a:	c1 fa 02             	sar    $0x2,%edx
  80122d:	89 c8                	mov    %ecx,%eax
  80122f:	c1 f8 1f             	sar    $0x1f,%eax
  801232:	29 c2                	sub    %eax,%edx
  801234:	89 d0                	mov    %edx,%eax
  801236:	c1 e0 02             	shl    $0x2,%eax
  801239:	01 d0                	add    %edx,%eax
  80123b:	01 c0                	add    %eax,%eax
  80123d:	29 c1                	sub    %eax,%ecx
  80123f:	89 ca                	mov    %ecx,%edx
  801241:	85 d2                	test   %edx,%edx
  801243:	75 9c                	jne    8011e1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801245:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80124c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124f:	48                   	dec    %eax
  801250:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801253:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801257:	74 3d                	je     801296 <ltostr+0xe2>
		start = 1 ;
  801259:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801260:	eb 34                	jmp    801296 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801262:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801265:	8b 45 0c             	mov    0xc(%ebp),%eax
  801268:	01 d0                	add    %edx,%eax
  80126a:	8a 00                	mov    (%eax),%al
  80126c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80126f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	01 c2                	add    %eax,%edx
  801277:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	01 c8                	add    %ecx,%eax
  80127f:	8a 00                	mov    (%eax),%al
  801281:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801283:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	01 c2                	add    %eax,%edx
  80128b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80128e:	88 02                	mov    %al,(%edx)
		start++ ;
  801290:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801293:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801296:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801299:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129c:	7c c4                	jl     801262 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80129e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a4:	01 d0                	add    %edx,%eax
  8012a6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012a9:	90                   	nop
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
  8012af:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012b2:	ff 75 08             	pushl  0x8(%ebp)
  8012b5:	e8 54 fa ff ff       	call   800d0e <strlen>
  8012ba:	83 c4 04             	add    $0x4,%esp
  8012bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012c0:	ff 75 0c             	pushl  0xc(%ebp)
  8012c3:	e8 46 fa ff ff       	call   800d0e <strlen>
  8012c8:	83 c4 04             	add    $0x4,%esp
  8012cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012dc:	eb 17                	jmp    8012f5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e4:	01 c2                	add    %eax,%edx
  8012e6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	01 c8                	add    %ecx,%eax
  8012ee:	8a 00                	mov    (%eax),%al
  8012f0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012f2:	ff 45 fc             	incl   -0x4(%ebp)
  8012f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012fb:	7c e1                	jl     8012de <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801304:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80130b:	eb 1f                	jmp    80132c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80130d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801310:	8d 50 01             	lea    0x1(%eax),%edx
  801313:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801316:	89 c2                	mov    %eax,%edx
  801318:	8b 45 10             	mov    0x10(%ebp),%eax
  80131b:	01 c2                	add    %eax,%edx
  80131d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801320:	8b 45 0c             	mov    0xc(%ebp),%eax
  801323:	01 c8                	add    %ecx,%eax
  801325:	8a 00                	mov    (%eax),%al
  801327:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801329:	ff 45 f8             	incl   -0x8(%ebp)
  80132c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801332:	7c d9                	jl     80130d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801334:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801337:	8b 45 10             	mov    0x10(%ebp),%eax
  80133a:	01 d0                	add    %edx,%eax
  80133c:	c6 00 00             	movb   $0x0,(%eax)
}
  80133f:	90                   	nop
  801340:	c9                   	leave  
  801341:	c3                   	ret    

00801342 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801342:	55                   	push   %ebp
  801343:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801345:	8b 45 14             	mov    0x14(%ebp),%eax
  801348:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80134e:	8b 45 14             	mov    0x14(%ebp),%eax
  801351:	8b 00                	mov    (%eax),%eax
  801353:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80135a:	8b 45 10             	mov    0x10(%ebp),%eax
  80135d:	01 d0                	add    %edx,%eax
  80135f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801365:	eb 0c                	jmp    801373 <strsplit+0x31>
			*string++ = 0;
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	8d 50 01             	lea    0x1(%eax),%edx
  80136d:	89 55 08             	mov    %edx,0x8(%ebp)
  801370:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	84 c0                	test   %al,%al
  80137a:	74 18                	je     801394 <strsplit+0x52>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	0f be c0             	movsbl %al,%eax
  801384:	50                   	push   %eax
  801385:	ff 75 0c             	pushl  0xc(%ebp)
  801388:	e8 13 fb ff ff       	call   800ea0 <strchr>
  80138d:	83 c4 08             	add    $0x8,%esp
  801390:	85 c0                	test   %eax,%eax
  801392:	75 d3                	jne    801367 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	84 c0                	test   %al,%al
  80139b:	74 5a                	je     8013f7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80139d:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a0:	8b 00                	mov    (%eax),%eax
  8013a2:	83 f8 0f             	cmp    $0xf,%eax
  8013a5:	75 07                	jne    8013ae <strsplit+0x6c>
		{
			return 0;
  8013a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8013ac:	eb 66                	jmp    801414 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b1:	8b 00                	mov    (%eax),%eax
  8013b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8013b6:	8b 55 14             	mov    0x14(%ebp),%edx
  8013b9:	89 0a                	mov    %ecx,(%edx)
  8013bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c5:	01 c2                	add    %eax,%edx
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013cc:	eb 03                	jmp    8013d1 <strsplit+0x8f>
			string++;
  8013ce:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	84 c0                	test   %al,%al
  8013d8:	74 8b                	je     801365 <strsplit+0x23>
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	8a 00                	mov    (%eax),%al
  8013df:	0f be c0             	movsbl %al,%eax
  8013e2:	50                   	push   %eax
  8013e3:	ff 75 0c             	pushl  0xc(%ebp)
  8013e6:	e8 b5 fa ff ff       	call   800ea0 <strchr>
  8013eb:	83 c4 08             	add    $0x8,%esp
  8013ee:	85 c0                	test   %eax,%eax
  8013f0:	74 dc                	je     8013ce <strsplit+0x8c>
			string++;
	}
  8013f2:	e9 6e ff ff ff       	jmp    801365 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013f7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fb:	8b 00                	mov    (%eax),%eax
  8013fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801404:	8b 45 10             	mov    0x10(%ebp),%eax
  801407:	01 d0                	add    %edx,%eax
  801409:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80140f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
  801419:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80141c:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801423:	76 0a                	jbe    80142f <malloc+0x19>
		return NULL;
  801425:	b8 00 00 00 00       	mov    $0x0,%eax
  80142a:	e9 ad 02 00 00       	jmp    8016dc <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	c1 e8 0c             	shr    $0xc,%eax
  801435:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	25 ff 0f 00 00       	and    $0xfff,%eax
  801440:	85 c0                	test   %eax,%eax
  801442:	74 03                	je     801447 <malloc+0x31>
		num++;
  801444:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801447:	a1 28 30 80 00       	mov    0x803028,%eax
  80144c:	85 c0                	test   %eax,%eax
  80144e:	75 71                	jne    8014c1 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801450:	a1 04 30 80 00       	mov    0x803004,%eax
  801455:	83 ec 08             	sub    $0x8,%esp
  801458:	ff 75 08             	pushl  0x8(%ebp)
  80145b:	50                   	push   %eax
  80145c:	e8 ba 05 00 00       	call   801a1b <sys_allocateMem>
  801461:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801464:	a1 04 30 80 00       	mov    0x803004,%eax
  801469:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  80146c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80146f:	c1 e0 0c             	shl    $0xc,%eax
  801472:	89 c2                	mov    %eax,%edx
  801474:	a1 04 30 80 00       	mov    0x803004,%eax
  801479:	01 d0                	add    %edx,%eax
  80147b:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801480:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801485:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801488:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  80148f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801494:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801497:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  80149e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014a3:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8014aa:	01 00 00 00 
		sizeofarray++;
  8014ae:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014b3:	40                   	inc    %eax
  8014b4:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  8014b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8014bc:	e9 1b 02 00 00       	jmp    8016dc <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8014c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8014c8:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8014cf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  8014d6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8014dd:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8014e4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8014eb:	eb 72                	jmp    80155f <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8014ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014f0:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8014f7:	85 c0                	test   %eax,%eax
  8014f9:	75 12                	jne    80150d <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8014fb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014fe:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801505:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801508:	ff 45 dc             	incl   -0x24(%ebp)
  80150b:	eb 4f                	jmp    80155c <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  80150d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801510:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801513:	7d 39                	jge    80154e <malloc+0x138>
  801515:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801518:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80151b:	7c 31                	jl     80154e <malloc+0x138>
					{
						min=count;
  80151d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801520:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801523:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801526:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80152d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801530:	c1 e2 0c             	shl    $0xc,%edx
  801533:	29 d0                	sub    %edx,%eax
  801535:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801538:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80153b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80153e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801541:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801548:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80154b:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  80154e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801555:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  80155c:	ff 45 d4             	incl   -0x2c(%ebp)
  80155f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801564:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801567:	7c 84                	jl     8014ed <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801569:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  80156d:	0f 85 e3 00 00 00    	jne    801656 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801573:	83 ec 08             	sub    $0x8,%esp
  801576:	ff 75 08             	pushl  0x8(%ebp)
  801579:	ff 75 e0             	pushl  -0x20(%ebp)
  80157c:	e8 9a 04 00 00       	call   801a1b <sys_allocateMem>
  801581:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801584:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801589:	40                   	inc    %eax
  80158a:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  80158f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801594:	48                   	dec    %eax
  801595:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801598:	eb 42                	jmp    8015dc <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  80159a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80159d:	48                   	dec    %eax
  80159e:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  8015a5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015a8:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  8015af:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015b2:	48                   	dec    %eax
  8015b3:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  8015ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015bd:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  8015c4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015c7:	48                   	dec    %eax
  8015c8:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  8015cf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015d2:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  8015d9:	ff 4d d0             	decl   -0x30(%ebp)
  8015dc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8015df:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015e2:	7f b6                	jg     80159a <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8015e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015e7:	40                   	inc    %eax
  8015e8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8015eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8015ee:	01 ca                	add    %ecx,%edx
  8015f0:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8015f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015fa:	8d 50 01             	lea    0x1(%eax),%edx
  8015fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801600:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801607:	2b 45 f4             	sub    -0xc(%ebp),%eax
  80160a:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801611:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801614:	40                   	inc    %eax
  801615:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  80161c:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801623:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801626:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  80162d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801630:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801633:	eb 11                	jmp    801646 <malloc+0x230>
				{
					changed[index] = 1;
  801635:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801638:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  80163f:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801643:	ff 45 cc             	incl   -0x34(%ebp)
  801646:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801649:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80164c:	7c e7                	jl     801635 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  80164e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801651:	e9 86 00 00 00       	jmp    8016dc <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801656:	a1 04 30 80 00       	mov    0x803004,%eax
  80165b:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801660:	29 c2                	sub    %eax,%edx
  801662:	89 d0                	mov    %edx,%eax
  801664:	3b 45 08             	cmp    0x8(%ebp),%eax
  801667:	73 07                	jae    801670 <malloc+0x25a>
						return NULL;
  801669:	b8 00 00 00 00       	mov    $0x0,%eax
  80166e:	eb 6c                	jmp    8016dc <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801670:	a1 04 30 80 00       	mov    0x803004,%eax
  801675:	83 ec 08             	sub    $0x8,%esp
  801678:	ff 75 08             	pushl  0x8(%ebp)
  80167b:	50                   	push   %eax
  80167c:	e8 9a 03 00 00       	call   801a1b <sys_allocateMem>
  801681:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801684:	a1 04 30 80 00       	mov    0x803004,%eax
  801689:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  80168c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80168f:	c1 e0 0c             	shl    $0xc,%eax
  801692:	89 c2                	mov    %eax,%edx
  801694:	a1 04 30 80 00       	mov    0x803004,%eax
  801699:	01 d0                	add    %edx,%eax
  80169b:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  8016a0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016a8:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  8016af:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016b4:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8016b7:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  8016be:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016c3:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8016ca:	01 00 00 00 
					sizeofarray++;
  8016ce:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016d3:	40                   	inc    %eax
  8016d4:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  8016d9:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8016ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8016f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8016f8:	eb 30                	jmp    80172a <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8016fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016fd:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801704:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801707:	75 1e                	jne    801727 <free+0x49>
  801709:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80170c:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801713:	83 f8 01             	cmp    $0x1,%eax
  801716:	75 0f                	jne    801727 <free+0x49>
			is_found = 1;
  801718:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  80171f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801722:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801725:	eb 0d                	jmp    801734 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801727:	ff 45 ec             	incl   -0x14(%ebp)
  80172a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80172f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801732:	7c c6                	jl     8016fa <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801734:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801738:	75 3a                	jne    801774 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  80173a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80173d:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801744:	c1 e0 0c             	shl    $0xc,%eax
  801747:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  80174a:	83 ec 08             	sub    $0x8,%esp
  80174d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801750:	ff 75 e8             	pushl  -0x18(%ebp)
  801753:	e8 a7 02 00 00       	call   8019ff <sys_freeMem>
  801758:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  80175b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80175e:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801765:	00 00 00 00 
		changes++;
  801769:	a1 28 30 80 00       	mov    0x803028,%eax
  80176e:	40                   	inc    %eax
  80176f:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801774:	90                   	nop
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
  80177a:	83 ec 18             	sub    $0x18,%esp
  80177d:	8b 45 10             	mov    0x10(%ebp),%eax
  801780:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801783:	83 ec 04             	sub    $0x4,%esp
  801786:	68 90 27 80 00       	push   $0x802790
  80178b:	68 b6 00 00 00       	push   $0xb6
  801790:	68 b3 27 80 00       	push   $0x8027b3
  801795:	e8 0b 07 00 00       	call   801ea5 <_panic>

0080179a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
  80179d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017a0:	83 ec 04             	sub    $0x4,%esp
  8017a3:	68 90 27 80 00       	push   $0x802790
  8017a8:	68 bb 00 00 00       	push   $0xbb
  8017ad:	68 b3 27 80 00       	push   $0x8027b3
  8017b2:	e8 ee 06 00 00       	call   801ea5 <_panic>

008017b7 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
  8017ba:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017bd:	83 ec 04             	sub    $0x4,%esp
  8017c0:	68 90 27 80 00       	push   $0x802790
  8017c5:	68 c0 00 00 00       	push   $0xc0
  8017ca:	68 b3 27 80 00       	push   $0x8027b3
  8017cf:	e8 d1 06 00 00       	call   801ea5 <_panic>

008017d4 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
  8017d7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017da:	83 ec 04             	sub    $0x4,%esp
  8017dd:	68 90 27 80 00       	push   $0x802790
  8017e2:	68 c4 00 00 00       	push   $0xc4
  8017e7:	68 b3 27 80 00       	push   $0x8027b3
  8017ec:	e8 b4 06 00 00       	call   801ea5 <_panic>

008017f1 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017f7:	83 ec 04             	sub    $0x4,%esp
  8017fa:	68 90 27 80 00       	push   $0x802790
  8017ff:	68 c9 00 00 00       	push   $0xc9
  801804:	68 b3 27 80 00       	push   $0x8027b3
  801809:	e8 97 06 00 00       	call   801ea5 <_panic>

0080180e <shrink>:
}
void shrink(uint32 newSize) {
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801814:	83 ec 04             	sub    $0x4,%esp
  801817:	68 90 27 80 00       	push   $0x802790
  80181c:	68 cc 00 00 00       	push   $0xcc
  801821:	68 b3 27 80 00       	push   $0x8027b3
  801826:	e8 7a 06 00 00       	call   801ea5 <_panic>

0080182b <freeHeap>:
}

void freeHeap(void* virtual_address) {
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
  80182e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801831:	83 ec 04             	sub    $0x4,%esp
  801834:	68 90 27 80 00       	push   $0x802790
  801839:	68 d0 00 00 00       	push   $0xd0
  80183e:	68 b3 27 80 00       	push   $0x8027b3
  801843:	e8 5d 06 00 00       	call   801ea5 <_panic>

00801848 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
  80184b:	57                   	push   %edi
  80184c:	56                   	push   %esi
  80184d:	53                   	push   %ebx
  80184e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	8b 55 0c             	mov    0xc(%ebp),%edx
  801857:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80185d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801860:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801863:	cd 30                	int    $0x30
  801865:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801868:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80186b:	83 c4 10             	add    $0x10,%esp
  80186e:	5b                   	pop    %ebx
  80186f:	5e                   	pop    %esi
  801870:	5f                   	pop    %edi
  801871:	5d                   	pop    %ebp
  801872:	c3                   	ret    

00801873 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
  801876:	83 ec 04             	sub    $0x4,%esp
  801879:	8b 45 10             	mov    0x10(%ebp),%eax
  80187c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80187f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801883:	8b 45 08             	mov    0x8(%ebp),%eax
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	52                   	push   %edx
  80188b:	ff 75 0c             	pushl  0xc(%ebp)
  80188e:	50                   	push   %eax
  80188f:	6a 00                	push   $0x0
  801891:	e8 b2 ff ff ff       	call   801848 <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	90                   	nop
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <sys_cgetc>:

int
sys_cgetc(void)
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 01                	push   $0x1
  8018ab:	e8 98 ff ff ff       	call   801848 <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	50                   	push   %eax
  8018c4:	6a 05                	push   $0x5
  8018c6:	e8 7d ff ff ff       	call   801848 <syscall>
  8018cb:	83 c4 18             	add    $0x18,%esp
}
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 02                	push   $0x2
  8018df:	e8 64 ff ff ff       	call   801848 <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
}
  8018e7:	c9                   	leave  
  8018e8:	c3                   	ret    

008018e9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018e9:	55                   	push   %ebp
  8018ea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 03                	push   $0x3
  8018f8:	e8 4b ff ff ff       	call   801848 <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
}
  801900:	c9                   	leave  
  801901:	c3                   	ret    

00801902 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801902:	55                   	push   %ebp
  801903:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 04                	push   $0x4
  801911:	e8 32 ff ff ff       	call   801848 <syscall>
  801916:	83 c4 18             	add    $0x18,%esp
}
  801919:	c9                   	leave  
  80191a:	c3                   	ret    

0080191b <sys_env_exit>:


void sys_env_exit(void)
{
  80191b:	55                   	push   %ebp
  80191c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 06                	push   $0x6
  80192a:	e8 19 ff ff ff       	call   801848 <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
}
  801932:	90                   	nop
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801938:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193b:	8b 45 08             	mov    0x8(%ebp),%eax
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	52                   	push   %edx
  801945:	50                   	push   %eax
  801946:	6a 07                	push   $0x7
  801948:	e8 fb fe ff ff       	call   801848 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	56                   	push   %esi
  801956:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801957:	8b 75 18             	mov    0x18(%ebp),%esi
  80195a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80195d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801960:	8b 55 0c             	mov    0xc(%ebp),%edx
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	56                   	push   %esi
  801967:	53                   	push   %ebx
  801968:	51                   	push   %ecx
  801969:	52                   	push   %edx
  80196a:	50                   	push   %eax
  80196b:	6a 08                	push   $0x8
  80196d:	e8 d6 fe ff ff       	call   801848 <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
}
  801975:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801978:	5b                   	pop    %ebx
  801979:	5e                   	pop    %esi
  80197a:	5d                   	pop    %ebp
  80197b:	c3                   	ret    

0080197c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80197f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	52                   	push   %edx
  80198c:	50                   	push   %eax
  80198d:	6a 09                	push   $0x9
  80198f:	e8 b4 fe ff ff       	call   801848 <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	ff 75 0c             	pushl  0xc(%ebp)
  8019a5:	ff 75 08             	pushl  0x8(%ebp)
  8019a8:	6a 0a                	push   $0xa
  8019aa:	e8 99 fe ff ff       	call   801848 <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
}
  8019b2:	c9                   	leave  
  8019b3:	c3                   	ret    

008019b4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019b4:	55                   	push   %ebp
  8019b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 0b                	push   $0xb
  8019c3:	e8 80 fe ff ff       	call   801848 <syscall>
  8019c8:	83 c4 18             	add    $0x18,%esp
}
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 0c                	push   $0xc
  8019dc:	e8 67 fe ff ff       	call   801848 <syscall>
  8019e1:	83 c4 18             	add    $0x18,%esp
}
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 0d                	push   $0xd
  8019f5:	e8 4e fe ff ff       	call   801848 <syscall>
  8019fa:	83 c4 18             	add    $0x18,%esp
}
  8019fd:	c9                   	leave  
  8019fe:	c3                   	ret    

008019ff <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	ff 75 0c             	pushl  0xc(%ebp)
  801a0b:	ff 75 08             	pushl  0x8(%ebp)
  801a0e:	6a 11                	push   $0x11
  801a10:	e8 33 fe ff ff       	call   801848 <syscall>
  801a15:	83 c4 18             	add    $0x18,%esp
	return;
  801a18:	90                   	nop
}
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	ff 75 0c             	pushl  0xc(%ebp)
  801a27:	ff 75 08             	pushl  0x8(%ebp)
  801a2a:	6a 12                	push   $0x12
  801a2c:	e8 17 fe ff ff       	call   801848 <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
	return ;
  801a34:	90                   	nop
}
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 0e                	push   $0xe
  801a46:	e8 fd fd ff ff       	call   801848 <syscall>
  801a4b:	83 c4 18             	add    $0x18,%esp
}
  801a4e:	c9                   	leave  
  801a4f:	c3                   	ret    

00801a50 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	ff 75 08             	pushl  0x8(%ebp)
  801a5e:	6a 0f                	push   $0xf
  801a60:	e8 e3 fd ff ff       	call   801848 <syscall>
  801a65:	83 c4 18             	add    $0x18,%esp
}
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 10                	push   $0x10
  801a79:	e8 ca fd ff ff       	call   801848 <syscall>
  801a7e:	83 c4 18             	add    $0x18,%esp
}
  801a81:	90                   	nop
  801a82:	c9                   	leave  
  801a83:	c3                   	ret    

00801a84 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a84:	55                   	push   %ebp
  801a85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 14                	push   $0x14
  801a93:	e8 b0 fd ff ff       	call   801848 <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	90                   	nop
  801a9c:	c9                   	leave  
  801a9d:	c3                   	ret    

00801a9e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 15                	push   $0x15
  801aad:	e8 96 fd ff ff       	call   801848 <syscall>
  801ab2:	83 c4 18             	add    $0x18,%esp
}
  801ab5:	90                   	nop
  801ab6:	c9                   	leave  
  801ab7:	c3                   	ret    

00801ab8 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ab8:	55                   	push   %ebp
  801ab9:	89 e5                	mov    %esp,%ebp
  801abb:	83 ec 04             	sub    $0x4,%esp
  801abe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ac4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	50                   	push   %eax
  801ad1:	6a 16                	push   $0x16
  801ad3:	e8 70 fd ff ff       	call   801848 <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
}
  801adb:	90                   	nop
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 17                	push   $0x17
  801aed:	e8 56 fd ff ff       	call   801848 <syscall>
  801af2:	83 c4 18             	add    $0x18,%esp
}
  801af5:	90                   	nop
  801af6:	c9                   	leave  
  801af7:	c3                   	ret    

00801af8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801af8:	55                   	push   %ebp
  801af9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801afb:	8b 45 08             	mov    0x8(%ebp),%eax
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	ff 75 0c             	pushl  0xc(%ebp)
  801b07:	50                   	push   %eax
  801b08:	6a 18                	push   $0x18
  801b0a:	e8 39 fd ff ff       	call   801848 <syscall>
  801b0f:	83 c4 18             	add    $0x18,%esp
}
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	52                   	push   %edx
  801b24:	50                   	push   %eax
  801b25:	6a 1b                	push   $0x1b
  801b27:	e8 1c fd ff ff       	call   801848 <syscall>
  801b2c:	83 c4 18             	add    $0x18,%esp
}
  801b2f:	c9                   	leave  
  801b30:	c3                   	ret    

00801b31 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	52                   	push   %edx
  801b41:	50                   	push   %eax
  801b42:	6a 19                	push   $0x19
  801b44:	e8 ff fc ff ff       	call   801848 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
}
  801b4c:	90                   	nop
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b55:	8b 45 08             	mov    0x8(%ebp),%eax
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	52                   	push   %edx
  801b5f:	50                   	push   %eax
  801b60:	6a 1a                	push   $0x1a
  801b62:	e8 e1 fc ff ff       	call   801848 <syscall>
  801b67:	83 c4 18             	add    $0x18,%esp
}
  801b6a:	90                   	nop
  801b6b:	c9                   	leave  
  801b6c:	c3                   	ret    

00801b6d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b6d:	55                   	push   %ebp
  801b6e:	89 e5                	mov    %esp,%ebp
  801b70:	83 ec 04             	sub    $0x4,%esp
  801b73:	8b 45 10             	mov    0x10(%ebp),%eax
  801b76:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b79:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b7c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b80:	8b 45 08             	mov    0x8(%ebp),%eax
  801b83:	6a 00                	push   $0x0
  801b85:	51                   	push   %ecx
  801b86:	52                   	push   %edx
  801b87:	ff 75 0c             	pushl  0xc(%ebp)
  801b8a:	50                   	push   %eax
  801b8b:	6a 1c                	push   $0x1c
  801b8d:	e8 b6 fc ff ff       	call   801848 <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
}
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	52                   	push   %edx
  801ba7:	50                   	push   %eax
  801ba8:	6a 1d                	push   $0x1d
  801baa:	e8 99 fc ff ff       	call   801848 <syscall>
  801baf:	83 c4 18             	add    $0x18,%esp
}
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801bb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	51                   	push   %ecx
  801bc5:	52                   	push   %edx
  801bc6:	50                   	push   %eax
  801bc7:	6a 1e                	push   $0x1e
  801bc9:	e8 7a fc ff ff       	call   801848 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
}
  801bd1:	c9                   	leave  
  801bd2:	c3                   	ret    

00801bd3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	52                   	push   %edx
  801be3:	50                   	push   %eax
  801be4:	6a 1f                	push   $0x1f
  801be6:	e8 5d fc ff ff       	call   801848 <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
}
  801bee:	c9                   	leave  
  801bef:	c3                   	ret    

00801bf0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 20                	push   $0x20
  801bff:	e8 44 fc ff ff       	call   801848 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0f:	6a 00                	push   $0x0
  801c11:	ff 75 14             	pushl  0x14(%ebp)
  801c14:	ff 75 10             	pushl  0x10(%ebp)
  801c17:	ff 75 0c             	pushl  0xc(%ebp)
  801c1a:	50                   	push   %eax
  801c1b:	6a 21                	push   $0x21
  801c1d:	e8 26 fc ff ff       	call   801848 <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
}
  801c25:	c9                   	leave  
  801c26:	c3                   	ret    

00801c27 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c27:	55                   	push   %ebp
  801c28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	50                   	push   %eax
  801c36:	6a 22                	push   $0x22
  801c38:	e8 0b fc ff ff       	call   801848 <syscall>
  801c3d:	83 c4 18             	add    $0x18,%esp
}
  801c40:	90                   	nop
  801c41:	c9                   	leave  
  801c42:	c3                   	ret    

00801c43 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c43:	55                   	push   %ebp
  801c44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c46:	8b 45 08             	mov    0x8(%ebp),%eax
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	50                   	push   %eax
  801c52:	6a 23                	push   $0x23
  801c54:	e8 ef fb ff ff       	call   801848 <syscall>
  801c59:	83 c4 18             	add    $0x18,%esp
}
  801c5c:	90                   	nop
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
  801c62:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c65:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c68:	8d 50 04             	lea    0x4(%eax),%edx
  801c6b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	52                   	push   %edx
  801c75:	50                   	push   %eax
  801c76:	6a 24                	push   $0x24
  801c78:	e8 cb fb ff ff       	call   801848 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
	return result;
  801c80:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c83:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c89:	89 01                	mov    %eax,(%ecx)
  801c8b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c91:	c9                   	leave  
  801c92:	c2 04 00             	ret    $0x4

00801c95 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c95:	55                   	push   %ebp
  801c96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	ff 75 10             	pushl  0x10(%ebp)
  801c9f:	ff 75 0c             	pushl  0xc(%ebp)
  801ca2:	ff 75 08             	pushl  0x8(%ebp)
  801ca5:	6a 13                	push   $0x13
  801ca7:	e8 9c fb ff ff       	call   801848 <syscall>
  801cac:	83 c4 18             	add    $0x18,%esp
	return ;
  801caf:	90                   	nop
}
  801cb0:	c9                   	leave  
  801cb1:	c3                   	ret    

00801cb2 <sys_rcr2>:
uint32 sys_rcr2()
{
  801cb2:	55                   	push   %ebp
  801cb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 25                	push   $0x25
  801cc1:	e8 82 fb ff ff       	call   801848 <syscall>
  801cc6:	83 c4 18             	add    $0x18,%esp
}
  801cc9:	c9                   	leave  
  801cca:	c3                   	ret    

00801ccb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ccb:	55                   	push   %ebp
  801ccc:	89 e5                	mov    %esp,%ebp
  801cce:	83 ec 04             	sub    $0x4,%esp
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cd7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	50                   	push   %eax
  801ce4:	6a 26                	push   $0x26
  801ce6:	e8 5d fb ff ff       	call   801848 <syscall>
  801ceb:	83 c4 18             	add    $0x18,%esp
	return ;
  801cee:	90                   	nop
}
  801cef:	c9                   	leave  
  801cf0:	c3                   	ret    

00801cf1 <rsttst>:
void rsttst()
{
  801cf1:	55                   	push   %ebp
  801cf2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 28                	push   $0x28
  801d00:	e8 43 fb ff ff       	call   801848 <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
	return ;
  801d08:	90                   	nop
}
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
  801d0e:	83 ec 04             	sub    $0x4,%esp
  801d11:	8b 45 14             	mov    0x14(%ebp),%eax
  801d14:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d17:	8b 55 18             	mov    0x18(%ebp),%edx
  801d1a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d1e:	52                   	push   %edx
  801d1f:	50                   	push   %eax
  801d20:	ff 75 10             	pushl  0x10(%ebp)
  801d23:	ff 75 0c             	pushl  0xc(%ebp)
  801d26:	ff 75 08             	pushl  0x8(%ebp)
  801d29:	6a 27                	push   $0x27
  801d2b:	e8 18 fb ff ff       	call   801848 <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
	return ;
  801d33:	90                   	nop
}
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <chktst>:
void chktst(uint32 n)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	ff 75 08             	pushl  0x8(%ebp)
  801d44:	6a 29                	push   $0x29
  801d46:	e8 fd fa ff ff       	call   801848 <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d4e:	90                   	nop
}
  801d4f:	c9                   	leave  
  801d50:	c3                   	ret    

00801d51 <inctst>:

void inctst()
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 2a                	push   $0x2a
  801d60:	e8 e3 fa ff ff       	call   801848 <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
	return ;
  801d68:	90                   	nop
}
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <gettst>:
uint32 gettst()
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 2b                	push   $0x2b
  801d7a:	e8 c9 fa ff ff       	call   801848 <syscall>
  801d7f:	83 c4 18             	add    $0x18,%esp
}
  801d82:	c9                   	leave  
  801d83:	c3                   	ret    

00801d84 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d84:	55                   	push   %ebp
  801d85:	89 e5                	mov    %esp,%ebp
  801d87:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 2c                	push   $0x2c
  801d96:	e8 ad fa ff ff       	call   801848 <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
  801d9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801da1:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801da5:	75 07                	jne    801dae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801da7:	b8 01 00 00 00       	mov    $0x1,%eax
  801dac:	eb 05                	jmp    801db3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801dae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    

00801db5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801db5:	55                   	push   %ebp
  801db6:	89 e5                	mov    %esp,%ebp
  801db8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 2c                	push   $0x2c
  801dc7:	e8 7c fa ff ff       	call   801848 <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
  801dcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801dd2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801dd6:	75 07                	jne    801ddf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801dd8:	b8 01 00 00 00       	mov    $0x1,%eax
  801ddd:	eb 05                	jmp    801de4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ddf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de4:	c9                   	leave  
  801de5:	c3                   	ret    

00801de6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801de6:	55                   	push   %ebp
  801de7:	89 e5                	mov    %esp,%ebp
  801de9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 2c                	push   $0x2c
  801df8:	e8 4b fa ff ff       	call   801848 <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
  801e00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e03:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e07:	75 07                	jne    801e10 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e09:	b8 01 00 00 00       	mov    $0x1,%eax
  801e0e:	eb 05                	jmp    801e15 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e10:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e15:	c9                   	leave  
  801e16:	c3                   	ret    

00801e17 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e17:	55                   	push   %ebp
  801e18:	89 e5                	mov    %esp,%ebp
  801e1a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 2c                	push   $0x2c
  801e29:	e8 1a fa ff ff       	call   801848 <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
  801e31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e34:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e38:	75 07                	jne    801e41 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e3f:	eb 05                	jmp    801e46 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e41:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e46:	c9                   	leave  
  801e47:	c3                   	ret    

00801e48 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e48:	55                   	push   %ebp
  801e49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	ff 75 08             	pushl  0x8(%ebp)
  801e56:	6a 2d                	push   $0x2d
  801e58:	e8 eb f9 ff ff       	call   801848 <syscall>
  801e5d:	83 c4 18             	add    $0x18,%esp
	return ;
  801e60:	90                   	nop
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
  801e66:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e67:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e6a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e70:	8b 45 08             	mov    0x8(%ebp),%eax
  801e73:	6a 00                	push   $0x0
  801e75:	53                   	push   %ebx
  801e76:	51                   	push   %ecx
  801e77:	52                   	push   %edx
  801e78:	50                   	push   %eax
  801e79:	6a 2e                	push   $0x2e
  801e7b:	e8 c8 f9 ff ff       	call   801848 <syscall>
  801e80:	83 c4 18             	add    $0x18,%esp
}
  801e83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e86:	c9                   	leave  
  801e87:	c3                   	ret    

00801e88 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e88:	55                   	push   %ebp
  801e89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	52                   	push   %edx
  801e98:	50                   	push   %eax
  801e99:	6a 2f                	push   $0x2f
  801e9b:	e8 a8 f9 ff ff       	call   801848 <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
}
  801ea3:	c9                   	leave  
  801ea4:	c3                   	ret    

00801ea5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
  801ea8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801eab:	8d 45 10             	lea    0x10(%ebp),%eax
  801eae:	83 c0 04             	add    $0x4,%eax
  801eb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801eb4:	a1 20 9b 98 00       	mov    0x989b20,%eax
  801eb9:	85 c0                	test   %eax,%eax
  801ebb:	74 16                	je     801ed3 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801ebd:	a1 20 9b 98 00       	mov    0x989b20,%eax
  801ec2:	83 ec 08             	sub    $0x8,%esp
  801ec5:	50                   	push   %eax
  801ec6:	68 c0 27 80 00       	push   $0x8027c0
  801ecb:	e8 bc e7 ff ff       	call   80068c <cprintf>
  801ed0:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801ed3:	a1 00 30 80 00       	mov    0x803000,%eax
  801ed8:	ff 75 0c             	pushl  0xc(%ebp)
  801edb:	ff 75 08             	pushl  0x8(%ebp)
  801ede:	50                   	push   %eax
  801edf:	68 c5 27 80 00       	push   $0x8027c5
  801ee4:	e8 a3 e7 ff ff       	call   80068c <cprintf>
  801ee9:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801eec:	8b 45 10             	mov    0x10(%ebp),%eax
  801eef:	83 ec 08             	sub    $0x8,%esp
  801ef2:	ff 75 f4             	pushl  -0xc(%ebp)
  801ef5:	50                   	push   %eax
  801ef6:	e8 26 e7 ff ff       	call   800621 <vcprintf>
  801efb:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801efe:	83 ec 08             	sub    $0x8,%esp
  801f01:	6a 00                	push   $0x0
  801f03:	68 e1 27 80 00       	push   $0x8027e1
  801f08:	e8 14 e7 ff ff       	call   800621 <vcprintf>
  801f0d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801f10:	e8 95 e6 ff ff       	call   8005aa <exit>

	// should not return here
	while (1) ;
  801f15:	eb fe                	jmp    801f15 <_panic+0x70>

00801f17 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
  801f1a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801f1d:	a1 20 30 80 00       	mov    0x803020,%eax
  801f22:	8b 50 74             	mov    0x74(%eax),%edx
  801f25:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f28:	39 c2                	cmp    %eax,%edx
  801f2a:	74 14                	je     801f40 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801f2c:	83 ec 04             	sub    $0x4,%esp
  801f2f:	68 e4 27 80 00       	push   $0x8027e4
  801f34:	6a 26                	push   $0x26
  801f36:	68 30 28 80 00       	push   $0x802830
  801f3b:	e8 65 ff ff ff       	call   801ea5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801f40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801f47:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801f4e:	e9 b6 00 00 00       	jmp    802009 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801f53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f56:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f60:	01 d0                	add    %edx,%eax
  801f62:	8b 00                	mov    (%eax),%eax
  801f64:	85 c0                	test   %eax,%eax
  801f66:	75 08                	jne    801f70 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801f68:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801f6b:	e9 96 00 00 00       	jmp    802006 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801f70:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f77:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801f7e:	eb 5d                	jmp    801fdd <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801f80:	a1 20 30 80 00       	mov    0x803020,%eax
  801f85:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801f8b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801f8e:	c1 e2 04             	shl    $0x4,%edx
  801f91:	01 d0                	add    %edx,%eax
  801f93:	8a 40 04             	mov    0x4(%eax),%al
  801f96:	84 c0                	test   %al,%al
  801f98:	75 40                	jne    801fda <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801f9a:	a1 20 30 80 00       	mov    0x803020,%eax
  801f9f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801fa5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801fa8:	c1 e2 04             	shl    $0x4,%edx
  801fab:	01 d0                	add    %edx,%eax
  801fad:	8b 00                	mov    (%eax),%eax
  801faf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801fb2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801fb5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801fba:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801fbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fbf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc9:	01 c8                	add    %ecx,%eax
  801fcb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801fcd:	39 c2                	cmp    %eax,%edx
  801fcf:	75 09                	jne    801fda <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801fd1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801fd8:	eb 12                	jmp    801fec <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801fda:	ff 45 e8             	incl   -0x18(%ebp)
  801fdd:	a1 20 30 80 00       	mov    0x803020,%eax
  801fe2:	8b 50 74             	mov    0x74(%eax),%edx
  801fe5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801fe8:	39 c2                	cmp    %eax,%edx
  801fea:	77 94                	ja     801f80 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801fec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801ff0:	75 14                	jne    802006 <CheckWSWithoutLastIndex+0xef>
			panic(
  801ff2:	83 ec 04             	sub    $0x4,%esp
  801ff5:	68 3c 28 80 00       	push   $0x80283c
  801ffa:	6a 3a                	push   $0x3a
  801ffc:	68 30 28 80 00       	push   $0x802830
  802001:	e8 9f fe ff ff       	call   801ea5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802006:	ff 45 f0             	incl   -0x10(%ebp)
  802009:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80200c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80200f:	0f 8c 3e ff ff ff    	jl     801f53 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802015:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80201c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802023:	eb 20                	jmp    802045 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802025:	a1 20 30 80 00       	mov    0x803020,%eax
  80202a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  802030:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802033:	c1 e2 04             	shl    $0x4,%edx
  802036:	01 d0                	add    %edx,%eax
  802038:	8a 40 04             	mov    0x4(%eax),%al
  80203b:	3c 01                	cmp    $0x1,%al
  80203d:	75 03                	jne    802042 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80203f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802042:	ff 45 e0             	incl   -0x20(%ebp)
  802045:	a1 20 30 80 00       	mov    0x803020,%eax
  80204a:	8b 50 74             	mov    0x74(%eax),%edx
  80204d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802050:	39 c2                	cmp    %eax,%edx
  802052:	77 d1                	ja     802025 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802054:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802057:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80205a:	74 14                	je     802070 <CheckWSWithoutLastIndex+0x159>
		panic(
  80205c:	83 ec 04             	sub    $0x4,%esp
  80205f:	68 90 28 80 00       	push   $0x802890
  802064:	6a 44                	push   $0x44
  802066:	68 30 28 80 00       	push   $0x802830
  80206b:	e8 35 fe ff ff       	call   801ea5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  802070:	90                   	nop
  802071:	c9                   	leave  
  802072:	c3                   	ret    
  802073:	90                   	nop

00802074 <__udivdi3>:
  802074:	55                   	push   %ebp
  802075:	57                   	push   %edi
  802076:	56                   	push   %esi
  802077:	53                   	push   %ebx
  802078:	83 ec 1c             	sub    $0x1c,%esp
  80207b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80207f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802083:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802087:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80208b:	89 ca                	mov    %ecx,%edx
  80208d:	89 f8                	mov    %edi,%eax
  80208f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802093:	85 f6                	test   %esi,%esi
  802095:	75 2d                	jne    8020c4 <__udivdi3+0x50>
  802097:	39 cf                	cmp    %ecx,%edi
  802099:	77 65                	ja     802100 <__udivdi3+0x8c>
  80209b:	89 fd                	mov    %edi,%ebp
  80209d:	85 ff                	test   %edi,%edi
  80209f:	75 0b                	jne    8020ac <__udivdi3+0x38>
  8020a1:	b8 01 00 00 00       	mov    $0x1,%eax
  8020a6:	31 d2                	xor    %edx,%edx
  8020a8:	f7 f7                	div    %edi
  8020aa:	89 c5                	mov    %eax,%ebp
  8020ac:	31 d2                	xor    %edx,%edx
  8020ae:	89 c8                	mov    %ecx,%eax
  8020b0:	f7 f5                	div    %ebp
  8020b2:	89 c1                	mov    %eax,%ecx
  8020b4:	89 d8                	mov    %ebx,%eax
  8020b6:	f7 f5                	div    %ebp
  8020b8:	89 cf                	mov    %ecx,%edi
  8020ba:	89 fa                	mov    %edi,%edx
  8020bc:	83 c4 1c             	add    $0x1c,%esp
  8020bf:	5b                   	pop    %ebx
  8020c0:	5e                   	pop    %esi
  8020c1:	5f                   	pop    %edi
  8020c2:	5d                   	pop    %ebp
  8020c3:	c3                   	ret    
  8020c4:	39 ce                	cmp    %ecx,%esi
  8020c6:	77 28                	ja     8020f0 <__udivdi3+0x7c>
  8020c8:	0f bd fe             	bsr    %esi,%edi
  8020cb:	83 f7 1f             	xor    $0x1f,%edi
  8020ce:	75 40                	jne    802110 <__udivdi3+0x9c>
  8020d0:	39 ce                	cmp    %ecx,%esi
  8020d2:	72 0a                	jb     8020de <__udivdi3+0x6a>
  8020d4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020d8:	0f 87 9e 00 00 00    	ja     80217c <__udivdi3+0x108>
  8020de:	b8 01 00 00 00       	mov    $0x1,%eax
  8020e3:	89 fa                	mov    %edi,%edx
  8020e5:	83 c4 1c             	add    $0x1c,%esp
  8020e8:	5b                   	pop    %ebx
  8020e9:	5e                   	pop    %esi
  8020ea:	5f                   	pop    %edi
  8020eb:	5d                   	pop    %ebp
  8020ec:	c3                   	ret    
  8020ed:	8d 76 00             	lea    0x0(%esi),%esi
  8020f0:	31 ff                	xor    %edi,%edi
  8020f2:	31 c0                	xor    %eax,%eax
  8020f4:	89 fa                	mov    %edi,%edx
  8020f6:	83 c4 1c             	add    $0x1c,%esp
  8020f9:	5b                   	pop    %ebx
  8020fa:	5e                   	pop    %esi
  8020fb:	5f                   	pop    %edi
  8020fc:	5d                   	pop    %ebp
  8020fd:	c3                   	ret    
  8020fe:	66 90                	xchg   %ax,%ax
  802100:	89 d8                	mov    %ebx,%eax
  802102:	f7 f7                	div    %edi
  802104:	31 ff                	xor    %edi,%edi
  802106:	89 fa                	mov    %edi,%edx
  802108:	83 c4 1c             	add    $0x1c,%esp
  80210b:	5b                   	pop    %ebx
  80210c:	5e                   	pop    %esi
  80210d:	5f                   	pop    %edi
  80210e:	5d                   	pop    %ebp
  80210f:	c3                   	ret    
  802110:	bd 20 00 00 00       	mov    $0x20,%ebp
  802115:	89 eb                	mov    %ebp,%ebx
  802117:	29 fb                	sub    %edi,%ebx
  802119:	89 f9                	mov    %edi,%ecx
  80211b:	d3 e6                	shl    %cl,%esi
  80211d:	89 c5                	mov    %eax,%ebp
  80211f:	88 d9                	mov    %bl,%cl
  802121:	d3 ed                	shr    %cl,%ebp
  802123:	89 e9                	mov    %ebp,%ecx
  802125:	09 f1                	or     %esi,%ecx
  802127:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80212b:	89 f9                	mov    %edi,%ecx
  80212d:	d3 e0                	shl    %cl,%eax
  80212f:	89 c5                	mov    %eax,%ebp
  802131:	89 d6                	mov    %edx,%esi
  802133:	88 d9                	mov    %bl,%cl
  802135:	d3 ee                	shr    %cl,%esi
  802137:	89 f9                	mov    %edi,%ecx
  802139:	d3 e2                	shl    %cl,%edx
  80213b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80213f:	88 d9                	mov    %bl,%cl
  802141:	d3 e8                	shr    %cl,%eax
  802143:	09 c2                	or     %eax,%edx
  802145:	89 d0                	mov    %edx,%eax
  802147:	89 f2                	mov    %esi,%edx
  802149:	f7 74 24 0c          	divl   0xc(%esp)
  80214d:	89 d6                	mov    %edx,%esi
  80214f:	89 c3                	mov    %eax,%ebx
  802151:	f7 e5                	mul    %ebp
  802153:	39 d6                	cmp    %edx,%esi
  802155:	72 19                	jb     802170 <__udivdi3+0xfc>
  802157:	74 0b                	je     802164 <__udivdi3+0xf0>
  802159:	89 d8                	mov    %ebx,%eax
  80215b:	31 ff                	xor    %edi,%edi
  80215d:	e9 58 ff ff ff       	jmp    8020ba <__udivdi3+0x46>
  802162:	66 90                	xchg   %ax,%ax
  802164:	8b 54 24 08          	mov    0x8(%esp),%edx
  802168:	89 f9                	mov    %edi,%ecx
  80216a:	d3 e2                	shl    %cl,%edx
  80216c:	39 c2                	cmp    %eax,%edx
  80216e:	73 e9                	jae    802159 <__udivdi3+0xe5>
  802170:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802173:	31 ff                	xor    %edi,%edi
  802175:	e9 40 ff ff ff       	jmp    8020ba <__udivdi3+0x46>
  80217a:	66 90                	xchg   %ax,%ax
  80217c:	31 c0                	xor    %eax,%eax
  80217e:	e9 37 ff ff ff       	jmp    8020ba <__udivdi3+0x46>
  802183:	90                   	nop

00802184 <__umoddi3>:
  802184:	55                   	push   %ebp
  802185:	57                   	push   %edi
  802186:	56                   	push   %esi
  802187:	53                   	push   %ebx
  802188:	83 ec 1c             	sub    $0x1c,%esp
  80218b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80218f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802193:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802197:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80219b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80219f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021a3:	89 f3                	mov    %esi,%ebx
  8021a5:	89 fa                	mov    %edi,%edx
  8021a7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021ab:	89 34 24             	mov    %esi,(%esp)
  8021ae:	85 c0                	test   %eax,%eax
  8021b0:	75 1a                	jne    8021cc <__umoddi3+0x48>
  8021b2:	39 f7                	cmp    %esi,%edi
  8021b4:	0f 86 a2 00 00 00    	jbe    80225c <__umoddi3+0xd8>
  8021ba:	89 c8                	mov    %ecx,%eax
  8021bc:	89 f2                	mov    %esi,%edx
  8021be:	f7 f7                	div    %edi
  8021c0:	89 d0                	mov    %edx,%eax
  8021c2:	31 d2                	xor    %edx,%edx
  8021c4:	83 c4 1c             	add    $0x1c,%esp
  8021c7:	5b                   	pop    %ebx
  8021c8:	5e                   	pop    %esi
  8021c9:	5f                   	pop    %edi
  8021ca:	5d                   	pop    %ebp
  8021cb:	c3                   	ret    
  8021cc:	39 f0                	cmp    %esi,%eax
  8021ce:	0f 87 ac 00 00 00    	ja     802280 <__umoddi3+0xfc>
  8021d4:	0f bd e8             	bsr    %eax,%ebp
  8021d7:	83 f5 1f             	xor    $0x1f,%ebp
  8021da:	0f 84 ac 00 00 00    	je     80228c <__umoddi3+0x108>
  8021e0:	bf 20 00 00 00       	mov    $0x20,%edi
  8021e5:	29 ef                	sub    %ebp,%edi
  8021e7:	89 fe                	mov    %edi,%esi
  8021e9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021ed:	89 e9                	mov    %ebp,%ecx
  8021ef:	d3 e0                	shl    %cl,%eax
  8021f1:	89 d7                	mov    %edx,%edi
  8021f3:	89 f1                	mov    %esi,%ecx
  8021f5:	d3 ef                	shr    %cl,%edi
  8021f7:	09 c7                	or     %eax,%edi
  8021f9:	89 e9                	mov    %ebp,%ecx
  8021fb:	d3 e2                	shl    %cl,%edx
  8021fd:	89 14 24             	mov    %edx,(%esp)
  802200:	89 d8                	mov    %ebx,%eax
  802202:	d3 e0                	shl    %cl,%eax
  802204:	89 c2                	mov    %eax,%edx
  802206:	8b 44 24 08          	mov    0x8(%esp),%eax
  80220a:	d3 e0                	shl    %cl,%eax
  80220c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802210:	8b 44 24 08          	mov    0x8(%esp),%eax
  802214:	89 f1                	mov    %esi,%ecx
  802216:	d3 e8                	shr    %cl,%eax
  802218:	09 d0                	or     %edx,%eax
  80221a:	d3 eb                	shr    %cl,%ebx
  80221c:	89 da                	mov    %ebx,%edx
  80221e:	f7 f7                	div    %edi
  802220:	89 d3                	mov    %edx,%ebx
  802222:	f7 24 24             	mull   (%esp)
  802225:	89 c6                	mov    %eax,%esi
  802227:	89 d1                	mov    %edx,%ecx
  802229:	39 d3                	cmp    %edx,%ebx
  80222b:	0f 82 87 00 00 00    	jb     8022b8 <__umoddi3+0x134>
  802231:	0f 84 91 00 00 00    	je     8022c8 <__umoddi3+0x144>
  802237:	8b 54 24 04          	mov    0x4(%esp),%edx
  80223b:	29 f2                	sub    %esi,%edx
  80223d:	19 cb                	sbb    %ecx,%ebx
  80223f:	89 d8                	mov    %ebx,%eax
  802241:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802245:	d3 e0                	shl    %cl,%eax
  802247:	89 e9                	mov    %ebp,%ecx
  802249:	d3 ea                	shr    %cl,%edx
  80224b:	09 d0                	or     %edx,%eax
  80224d:	89 e9                	mov    %ebp,%ecx
  80224f:	d3 eb                	shr    %cl,%ebx
  802251:	89 da                	mov    %ebx,%edx
  802253:	83 c4 1c             	add    $0x1c,%esp
  802256:	5b                   	pop    %ebx
  802257:	5e                   	pop    %esi
  802258:	5f                   	pop    %edi
  802259:	5d                   	pop    %ebp
  80225a:	c3                   	ret    
  80225b:	90                   	nop
  80225c:	89 fd                	mov    %edi,%ebp
  80225e:	85 ff                	test   %edi,%edi
  802260:	75 0b                	jne    80226d <__umoddi3+0xe9>
  802262:	b8 01 00 00 00       	mov    $0x1,%eax
  802267:	31 d2                	xor    %edx,%edx
  802269:	f7 f7                	div    %edi
  80226b:	89 c5                	mov    %eax,%ebp
  80226d:	89 f0                	mov    %esi,%eax
  80226f:	31 d2                	xor    %edx,%edx
  802271:	f7 f5                	div    %ebp
  802273:	89 c8                	mov    %ecx,%eax
  802275:	f7 f5                	div    %ebp
  802277:	89 d0                	mov    %edx,%eax
  802279:	e9 44 ff ff ff       	jmp    8021c2 <__umoddi3+0x3e>
  80227e:	66 90                	xchg   %ax,%ax
  802280:	89 c8                	mov    %ecx,%eax
  802282:	89 f2                	mov    %esi,%edx
  802284:	83 c4 1c             	add    $0x1c,%esp
  802287:	5b                   	pop    %ebx
  802288:	5e                   	pop    %esi
  802289:	5f                   	pop    %edi
  80228a:	5d                   	pop    %ebp
  80228b:	c3                   	ret    
  80228c:	3b 04 24             	cmp    (%esp),%eax
  80228f:	72 06                	jb     802297 <__umoddi3+0x113>
  802291:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802295:	77 0f                	ja     8022a6 <__umoddi3+0x122>
  802297:	89 f2                	mov    %esi,%edx
  802299:	29 f9                	sub    %edi,%ecx
  80229b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80229f:	89 14 24             	mov    %edx,(%esp)
  8022a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022a6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022aa:	8b 14 24             	mov    (%esp),%edx
  8022ad:	83 c4 1c             	add    $0x1c,%esp
  8022b0:	5b                   	pop    %ebx
  8022b1:	5e                   	pop    %esi
  8022b2:	5f                   	pop    %edi
  8022b3:	5d                   	pop    %ebp
  8022b4:	c3                   	ret    
  8022b5:	8d 76 00             	lea    0x0(%esi),%esi
  8022b8:	2b 04 24             	sub    (%esp),%eax
  8022bb:	19 fa                	sbb    %edi,%edx
  8022bd:	89 d1                	mov    %edx,%ecx
  8022bf:	89 c6                	mov    %eax,%esi
  8022c1:	e9 71 ff ff ff       	jmp    802237 <__umoddi3+0xb3>
  8022c6:	66 90                	xchg   %ax,%ax
  8022c8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022cc:	72 ea                	jb     8022b8 <__umoddi3+0x134>
  8022ce:	89 d9                	mov    %ebx,%ecx
  8022d0:	e9 62 ff ff ff       	jmp    802237 <__umoddi3+0xb3>
