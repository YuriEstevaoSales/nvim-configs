#include <iostream>

int main(){

int n, k;
std::cin >> n >> k;

long long int num[n], querie;

for(int i=0;i<n;i++){
	std::cin >> num[i];
}

for(int j=0;j<k;j++){
	std::cin >> querie;
	int l=0, r=n-1;
	bool found=false;
	while(l<=r){
		if(num[(l+r)/2]==querie){
			std::cout << "YES" << std::endl;
			found=true;
			break;
		}
		if(num[(l+r)/2] > querie){
			r=((r+l)/2)-1;	
		}else{
			l=((r+l)/2)+1;
		}
	}
	if(!found){
		std::cout << "NO" << std::endl;
	}
}

return 0;
}
