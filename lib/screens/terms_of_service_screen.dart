import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hizmet Şartları'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '1. Kabul',
            content: '''
QR Scanner uygulamasını kullanarak bu hizmet şartlarını kabul etmiş sayılırsınız. Şartları kabul etmiyorsanız, lütfen uygulamayı kullanmayın.
''',
          ),
          _buildSection(
            title: '2. Lisans',
            content: '''
Size, QR Scanner uygulamasını kişisel, ticari olmayan kullanım için sınırlı, devredilemez, münhasır olmayan bir lisans verilmiştir.
''',
          ),
          _buildSection(
            title: '3. Kullanım Koşulları',
            content: '''
Uygulamayı kullanırken:

• Yasa dışı içerikler için QR kod oluşturmayacaksınız
• Başkalarının haklarını ihlal etmeyeceksiniz
• Uygulamayı kötü amaçlı kullanmayacaksınız
• Spam veya zararlı içerik paylaşmayacaksınız
''',
          ),
          _buildSection(
            title: '4. Sorumluluk Reddi',
            content: '''
Uygulama "olduğu gibi" sunulmaktadır. QR kodların içeriğinden veya kullanımından doğabilecek zararlardan sorumlu değiliz.

Taradığınız QR kodların güvenli olduğundan emin olun. Bilinmeyen kaynaklardan gelen QR kodlara dikkat edin.
''',
          ),
          _buildSection(
            title: '5. İçerik Sorumluluğu',
            content: '''
Oluşturduğunuz ve taradığınız QR kodların içeriğinden tamamen siz sorumlusunuz. Yasalara aykırı veya zararlı içerik oluşturmayın.
''',
          ),
          _buildSection(
            title: '6. Hizmet Değişiklikleri',
            content: '''
Uygulamanın özelliklerini, içeriğini veya kullanılabilirliğini önceden haber vermeksizin değiştirme hakkını saklı tutarız.
''',
          ),
          _buildSection(
            title: '7. Hesap Askıya Alma',
            content: '''
Bu şartları ihlal etmeniz durumunda, uygulamaya erişiminizi askıya alma veya sonlandırma hakkımız vardır.
''',
          ),
          _buildSection(
            title: '8. Fikri Mülkiyet',
            content: '''
Uygulamanın tüm içeriği, tasarımı ve kodu telif hakkı ile korunmaktadır. İzinsiz kopyalama, dağıtma veya değiştirme yasaktır.
''',
          ),
          _buildSection(
            title: '9. Üçüncü Taraf Bağlantılar',
            content: '''
Uygulama, üçüncü taraf web sitelerine veya hizmetlere bağlantılar içerebilir. Bu sitelerin içeriğinden veya gizlilik uygulamalarından sorumlu değiliz.
''',
          ),
          _buildSection(
            title: '10. Garanti Reddi',
            content: '''
Uygulama, hiçbir garanti olmaksızın sunulmaktadır. Kesintisiz veya hatasız çalışacağını garanti etmiyoruz.
''',
          ),
          _buildSection(
            title: '11. Şartlarda Değişiklik',
            content: '''
Bu hizmet şartlarını istediğimiz zaman değiştirme hakkını saklı tutarız. Önemli değişiklikler uygulama içinde duyurulacaktır.
''',
          ),
          _buildSection(
            title: '12. İletişim',
            content: '''
Hizmet şartları ile ilgili sorularınız için bizimle iletişime geçebilirsiniz.

Son Güncelleme: 10 Ekim 2025
''',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
