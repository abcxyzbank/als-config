cd ~/block-buster
git pull origin master --allow-unrelated-histories

flux create source git 9-demo-source-git-bb-app \
--url https://github.com/sid-demo/bb-app-source \
--branch 9-demo \
--timeout 10s 


flux create kustomization 9-demo-kustomize-git-bb-app \
--source GitRepository/9-demo-source-git-bb-app \
--prune true \
--interval 10s \
--target-namespace 9-demo \
--path manifests

kubectl apply -f - <<eof
apiVersion: v1
data:
  caFile: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJRENDQWdpZ0F3SUJBZ0lSQUtUOEZhZUhYK2Y5WmxBUktLTjNGR1V3RFFZSktvWklodmNOQVFFTEJRQXcKSWpFUU1BNEdBMVVFQ2hNSFFXTnRaU0JEYnpFT01Bd0dBMVVFQXhNRlIybDBaV0V3SGhjTk1qTXdOakE1TURreQpOVEF3V2hjTk1qUXdOakE0TURreU5UQXdXakFpTVJBd0RnWURWUVFLRXdkQlkyMWxJRU52TVE0d0RBWURWUVFECkV3VkhhWFJsWVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTlN6d3gyZ09ydEIKTmxtazRUdGJXcnZDbzdSd2JkaGFzZS9Mdk9XMWRmdHF4bHdGckVSWXlONzVjdEd5TUZFajJQNThDanNqK0FHaQpJdXZCY3A3QlRIam9HYTBSNCs2NWdZd0Qyc2NNMUtMUTBNRlNDOERKczRGQlFsOVhGNS9wNkxCNmh4MlJaV0c1CmhlOFBTNGk2WUZwdlJkeFFoN1VCN01WYWx4T2J4Rytjc0RIUitGR2JGTlJGR2dndEU2bmpVa3R1cGUwc1RwRCsKNlVCb1VQSmpHSzBPQWZqQzhyZ3NWd2Mwa1lscHlHR1QrZEw5WkE1b09lRHZWMTRCcllRNHJFYjBVYXVBQk5IagpKZDRyRi9zRk0wTUFHR3NVc0ZCbi9EOUdKbXlselpndFhtSXRrcm9DTWg3eFU0NXNDMFJhTEFqTlpGSklFUmNGCmVDdTFWVzZJRks4Q0F3RUFBYU5STUU4d0RnWURWUjBQQVFIL0JBUURBZ1dnTUJNR0ExVWRKUVFNTUFvR0NDc0cKQVFVRkJ3TUJNQXdHQTFVZEV3RUIvd1FDTUFBd0dnWURWUjBSQkJNd0VZSVBaMmwwTG1WNFlXMXdiR1V1WTI5dApNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUFETmFzdklFT2NaRURmOUJZQlozR1dIZlRRWUhHWGExd29lNVBYCmtBU3JGSmxER1BPN3BXMVFyYlMwYklvdGViQ0R5WXFCdWpsTU9jWnYrWGZITXFvdExBTm9qQkp5QWhQQW9NdTQKeGRlLzVWS0VMWURVM01aQS92ODNYZDB1d2RTc3I1N242M1VKa1dObXRpQzJzcHQ4MTloVnNiaE5RMU04SmxOSQppZGlKSFBtK2xCZyt6dFhGRmlMa2ZPTW94VFlCckU0Ykk0VURSTFNnL1pJMjA4dHhCSVBtdGtiY3lmNzFmRHRoCnR2ejNtZlFMeTdwVlRGa1YxTXVZR2NJTDNIdGljcjAzWFN6S2NDSnUyVzh3eGNDTDExaW5aNFg4VnAxUFhXdnkKYWhRd1k1Y01weUljL2c1N0tESVJZZHVIMVphWXZ4TW1FTkQySk5ydDNFY2V5R1YvCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
  password: Qm9iX3Bhc3MxMjM=
  username: Ym9i
kind: Secret
metadata:
  name: database-demo-source-git-bb-app
  namespace: flux-system
type: Opaque
eof

# flux create source git database-demo-source-git-bb-app     --url=https://git.example.com/bob/bb-app-source.git     --branch=master   --secret-ref=database-demo-source-git-bb-app  --export > ~/block-buster/flux-clusters/dev-cluster/database-demo-source-git-bb-app.yml

flux create source git database-demo-source-git-bb-app --url=https://git.example.com/bob/bb-app-source.git --username=bob --password=Bob_pass123 --branch=master --branch=master --ca-file=/var/lib/gitea/custom/cert.pem 


flux create kustomization database-demo-kustomize-git-bb-app \
--source GitRepository/database-demo-source-git-bb-app \
--prune true \
--interval 10s \
--target-namespace database \
--path database 

cd ~/block-buster
git add .
git commit -m "added some manifests"
git push origin master
