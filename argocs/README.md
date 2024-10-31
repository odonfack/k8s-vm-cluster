kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
watch kubectl get pods -n argocd

resetting the admin password in ArgoCD while ensuring a secure and straightforward approach

Step 1: Invalidating Admin Credentials
To initiate the password reset, we start by invalidating the current admin credentials. Run the following `kubectl` command to patch the ArgoCD secret:
```kubectl patch secret argocd-secret -n argocd -p '{"data": {"admin.password": null, "admin.passwordMtime": null}}' ```
This step renders the existing admin password useless, ensuring a clean slate for the upcoming password reset.
---
Step 2: Restarting ArgoCD Server Pods
Next, to apply the changes made in Step 1, we need to restart the ArgoCD server pods. Execute the following command to gracefully restart the pods:
``` kubectl delete pods -n argocd -l app.kubernetes.io/name=argocd-server ```
This ensures that the changes take effect and the ArgoCD server picks up the updated secret.
---
Step 3: Decrypting the New Password
Now that the admin credentials are reset, let’s generate a new password and decrypt it for secure access.

Run the following command to retrieve and decrypt the new password from the `argocd-initial-admin-secret`:
``` kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d ```

This command fetches the base64-encoded password, decodes it, and displays the new admin password.

---
Install argocd-cli
wget https://github.com/argoproj/argo-cd/releases/download/v2.11.0/argocd-linux-amd64
chmod +x argocd-linux-amd64
sudo mv argocd-linux-amd64 /usr/local/bin/argocd
argocd --help

