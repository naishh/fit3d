function SignChanges = getSignChanges(D)
SignChanges = []
for i=1:length(D)-1
	if (D(i)<0 && D(i+1)>0) || (D(i)>0 && D(i+1)<0)
		SignChanges = [SignChanges,i];
	end
end
