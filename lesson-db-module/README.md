Lesson 8-9 - CI/CD Automation with Jenkins & Argo CD (GitOps)
Цей проєкт демонструє повний цикл автоматизації інфраструктури та розгортання додатків (GitOps). Ми використовуємо Terraform для створення AWS EKS кластера, Jenkins для автоматизації збірки (CI) та Argo CD для декларативного розгортання в Kubernetes (CD).

Команди для роботи з інфраструктурою
Ініціалізація Terraform
Bash
terraform init
Команда завантажує провайдери AWS, Kubernetes, Helm та ініціалізує модулі.

Перегляд та застосування змін
Bash
terraform plan
terraform apply
Terraform створить VPC, ECR, EKS кластер, а також автоматично встановить Jenkins та Argo CD за допомогою Helm-чартів.

Автоматизація CI/CD
1. Перевірка Jenkins (CI Pipeline)
Jenkins відповідає за збірку Docker-образу та оновлення конфігурації.

Як зайти: Отримай URL сервісу Jenkins через kubectl get svc -n jenkins.

Логін: admin, Пароль: той, що вказаний у твоїх змінних Terraform.

Що перевірити:

Зайди в Pipeline django-app-pipeline.

Переконайся, що стадія Build and Push успішно відправила образ в ECR.

Стадія Update Manifest має автоматично змінити тег образу (image.tag) у твоєму GitHub репозиторії в гілці lesson-8-9.

2. Перегляд результату в Argo CD (GitOps)
Argo CD синхронізує стан твого кластера з кодом у GitHub.

Як зайти: Отримай URL через kubectl get svc -n argocd.

Що перевірити:

У консолі Argo CD ти побачиш застосунок django-app.

Статус Synced означає, що Argo CD побачив новий тег у GitHub і розгорнув його.

Статус Healthy означає, що поди Django успішно запущені.

Опис модулів
1. Модуль vpc
Створює мережеву інфраструктуру: 3 публічні та 3 приватні підмережі в різних зонах доступності для високої відмовостійкості.

2. Модуль ecr
Створює приватний реєстр django-app для зберігання версій твого додатку.

3. Модуль eks
Створює керований Kubernetes кластер. Включає Node Group на базі t3.small інстансів з автоматичним масштабуванням (від 2 до 6 нод).

4. Модуль jenkins
Встановлює Jenkins у кластер. Налаштовує Pipeline, який інтегрований з GitHub через Personal Access Token (PAT).

5. Модуль argo_cd
Розгортає Argo CD та створює об'єкт Application, який стежить за папкою charts/django-app у твоєму репозиторії.

Робота з Kubernetes та Перевірка
Налаштування доступу
Після створення кластера онови свій kubeconfig:

Bash
aws eks --region us-west-2 update-kubeconfig --name lesson-8-eks-cluster
Перевірка статусів розгортання
Bash
# Перевірити статус Argo CD додатків
kubectl get applications -n argocd

# Перевірити поди додатку Django
kubectl get pods -n jenkins

# Переглянути логи Argo CD (якщо виникли проблеми)
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-application-controller
Корисні команди Helm
Bash
# Переглянути всі встановлені інструменти (Argo, Jenkins, Apps)
helm list -A
Порядок розгортання проєкту
Застосування Terraform: Створює всю інфраструктуру та софт.

Запуск Jenkins Job: Відбувається автоматично при пуші в GitHub або вручну для створення Docker-образу.

Синхронізація Argo CD: Як тільки Jenkins оновить тег у Git, Argo CD миттєво оновить додаток у кластері.

Результат: Додаток доступний у кластері з актуальною версією коду.

Очищення ресурсів
Bash
terraform destroy