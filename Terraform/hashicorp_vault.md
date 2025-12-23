# HashiCorp Vault 
HashiCorp Vault is a secrets management and data protection tool used to secure, store, control, and dynamically generate sensitive information like passwords, API keys, tokens, and certificates.

**🔐 Why HashiCorp Vault is used**

In modern systems (especially DevOps & Kubernetes), secrets should not be:  

- Hard-coded in code  
- Stored in Git repos  
- Kept in plain text config files
  
👉 Vault solves this problem.

# 🧠 What Vault does

**1️⃣ Secure Secrets Storage**
- Encrypts secrets at rest and in transit  
- Stores secrets centrally  
- Fine-grained access control  

**Examples**  
- Database passwords  
- API keys  
- SSH keys  
- Cloud credentials
  
**2️⃣ Dynamic Secrets (Very Important 🔥)**  

Vault can generate secrets on demand and revoke them automatically.

**Example**

- Generates a DB username/password  
- Valid only for 1 hour  
- Automatically revoked after expiry
- 
👉 This is far more secure than static secrets.

**3️⃣ Authentication (Who are you?)**

Vault supports multiple auth methods:

- Kubernetes  
- AWS IAM  
- AppRole  
- LDAP  
- GitHub  
- Username/Password  

Example  
- A pod authenticates using Kubernetes ServiceAccount  
- Vault verifies it  
- Issues a short-lived token
  
**4️⃣ Authorization (What can you access?)**

- Uses policies (HCL or JSON)  
- Least-privilege access
  
Example policy
```
path "secret/data/db/*" {
  capabilities = ["read"]
}
```

**5️⃣ Encryption as a Service**

- Encrypt/decrypt data without storing it  
- Used for PII, tokens, credit card data
  
**6️⃣ Secret Rotation & Revocation**

- Automatically rotate secrets  
- Instantly revoke leaked credentials
  
**🏗️ How Vault Works (Simple Flow)**
```
Application → Authenticate → Get Vault Token
           → Request Secret → Vault Policy Check
           → Encrypted Secret Return
```

# ▬▬▬▬▬▬ ⭐️ Installation ⭐️ ▬▬▬▬▬▬ 

**Step 1 - Add PGP for the package signing key**

    sudo apt update && sudo apt install gpg

**Step 2 - Add the HashiCorp GPG key**

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg 

**Step 3 - Verify the key's fingerprint**

     gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

**Step 4 - Add the official HashiCorp Linux repository**

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

**Step 5 - Update and install**

    sudo apt update && sudo apt install vault

**Step 6 Verify version**

     vault -version

# Vault Start and Stop

  You can start in two modes  
  1. Dev mode - Mean to be start in development  
  2. Server mode - Mean to be start in production

**1. Start vault in dev**

     vault server -dev

<img width="1141" height="535" alt="image" src="https://github.com/user-attachments/assets/25c86837-b204-41b8-9112-265bc8317a4f" />

<img width="1138" height="770" alt="image" src="https://github.com/user-attachments/assets/21c92f8d-ea31-4baa-9295-8c24d630d80e" />

<img width="1816" height="421" alt="image" src="https://github.com/user-attachments/assets/4d12b874-e1d2-48aa-b72d-a8629ac0a042" />

**2. Export Vault token**

     export VAULT_ADDR='http://127.0.0.1:8200'
     export VAULT_TOKEN='root token'

**3. Check Vault status**

      vault status

# Vault command line interface(CLI)

1. Write

        vault kv put my/path key-1=value-1


2. Enable KV Secrets Engine via CLI

        vault secrets enable -path=my kv-v2

This enables the KV engine at:

    my/

You can verify:

    vault secrets list

<img width="485" height="341" alt="image" src="https://github.com/user-attachments/assets/b9abe8ce-a065-4393-9c39-015704f36568" />

3. Read the data

       vault kv get my/path

or 

       vault kv get --format=json my/path

4. Delete the secret

       vault kv delete my/path
   
