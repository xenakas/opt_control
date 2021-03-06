Vmin<-function(R,A){                        #������� �������� � ��������� ������� � ����������� ����� �����
  min<-Inf                                   
  nmin<-Inf 
  for (i in 1:n){ 
    if((R[i]<min)&(A[i]==0)){               
      min<-R[i] 
      nmin<-i 
    } 
  } 
  return(nmin)}

deikstra<-function(Gr,v1,v2){ 
  if((v1<=n)&(v2<=n)&(v2>0)&(v2>0)){ 
    num<-which(Gr[v1,]!=0)                   
      R<-rep(Inf,n)                          #������ ����� �����, ��������� �� v1, Inf, ������ � ���� ���� - 0
      for (j in 1:length(num)) { 
        R[num[j]]<-Gr[v1,num[j]]                          
        }                
      R[v1]<-0
    A<-rep(0,n)                              #������, ���������� ��� ���������� �������
    p<-rep(0,n)                              #������ ����� �� ��������
    for (j in 1:length(num)){ 
      p[num[j]]<-v1                          
      }                                      #p - ������ �� "0" � v1 �� ������ �������� ������
    while(Vmin(R,A)!=Inf){                 
      k<-Vmin(R,A)                           
      A[k]<-1                                #������� ������� ��������������
      for (s in 1:n){                        #���������� ��� ������ �������
        if((R[k]+Gr[k,s]<R[s])&(A[s]==0)&Gr[k,s]!=0) {  
          R[s]<-R[k]+Gr[k,s]                 #((���� ��� (v1,k)+��� (k,s)) ����� ������� � ���. ����� < ��� (v1,s), ����� (v1,s) �� �������������� 
          p[s]<-k                            #��������� ���� �� v1 ����� k � s � ���������� ����� �� ��������
          } 
       } 
    } 
    path<-v2                                 #�������������� ���� 
    i<-path[1]  
    while(p[i]!=0) {                         #0 = � ����� ����
      path<-c(p[i],path) 
      i<-path[1] 
    } 
    totalweight<-c(path,R[v2])} else { 
      totalweight<-c(Inf,Inf)} 
  return(totalweight)}

stolitsa<-function(Gr,num) {                
  S<-matrix(0,n,n)
  line<-c()
  for (i in 1:n){
    for (j in 1:n){
      r<-deikstra(Gr,i,j) 
      if (r[length(r)]!=Inf){
      S[i,j]<-r[length(r)]
      }else{
        return('���� �� �������')
        }
     }
  }
  if(num==3){                                 #���������� �������, ��� ����� �����
    for (i in 1:n){
      el<-max(S[i,])                          #���������������
      line<-c(line,el)
    }
    return(which.min(line))  
      }else{
        for (i in 1:n){
          el<-0
          for (j in 1:n){
            if(num==1){                       #���������� �������, ��� ������� � ����������� ������ ����������
              el<-S[i,j]+el
              }
            if(num==2){
              el<-S[i,j]*S[i,j]+el            #���������� �������, ��� ������� � ����������� ������ ��������� ����������
              }
           }
       line<-c(line,el)
       }
   return(which.min(line))
   }
}

otvet<-function(i){
  roads<-list()    
  for(j in 1:n){
    roads[[j]]<-deikstra(gr,i,j)
    } 
  return(roads)
}

gr<-matrix(0,ncol=15,nrow=15) 
n<-dim(gr)[1] 

gr[1,4]<-gr[4,1]<-45 
gr[1,5]<-gr[5,1]<-47 
gr[2,4]<-gr[4,2]<-53 
gr[2,5]<-gr[5,2]<-50 
gr[2,6]<-gr[6,2]<-48 
gr[3,5]<-gr[5,3]<-41 
gr[3,6]<-gr[6,3]<-49 
gr[4,7]<-gr[7,4]<-49 
gr[4,6]<-gr[6,4]<-53 
gr[5,8]<-gr[8,5]<-40 
gr[5,9]<-gr[9,5]<-48 
gr[6,9]<-gr[9,6]<-41 
gr[6,10]<-gr[10,6]<-39 
gr[7,8]<-gr[8,7]<-51 
gr[7,11]<-gr[11,7]<-45 
gr[7,13]<-gr[7,13]<-50 
gr[8,9]<-gr[9,8]<-47 
gr[8,11]<-gr[11,8]<-46 
gr[9,11]<-gr[11,9]<-52 
gr[9,15]<-gr[15,9]<-49 
gr[10,12]<-gr[12,10]<-48 
gr[11,13]<-gr[13,11]<-47 
gr[11,14]<-gr[14,11]<-57 
gr[12,14]<-gr[14,12]<-53 
gr[12,15]<-gr[15,12]<-43

library(igraph)
igr<-gr
igr<-igraph::graph.adjacency(adjmatrix=igr,weighted=TRUE,mode="undirected")
plot(igr, edge.label=round(c(45,47,53,50,48,41,49,53,49,40,48,41,39,51,45,50,47,46,52,49,48,47,57,53,43)))


deikstra(gr,5,14)


stolitsa(gr,1)

stolitsa(gr,2)

stolitsa(gr,3)

otvet(1)