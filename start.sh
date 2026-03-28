#!/bin/sh

# Espera o banco de dados estar disponível
echo "⏳ Aguardando banco de dados..."
until nc -z -v -w30 breeze_db 3306
do
  echo "⚙️  Aguardando conexão com o MySQL..."
  sleep 5
done
echo "✅ Banco de dados disponível!"

# Executa migrations e seeders
echo "🚀 Rodando migrations..."
php artisan migrate --force

# Opcional: rodar seed (por exemplo, criar usuário admin)
php artisan db:seed --force

# Inicia o servidor (Octane + FrankenPHP)
echo "🌐 Iniciando Laravel..."
exec php artisan octane:frankenphp --host=0.0.0.0 --port=80 --watch
