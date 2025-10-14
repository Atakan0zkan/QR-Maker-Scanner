import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gizlilik Politikası'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '1. Toplanan Bilgiler',
            content: '''
QR Scanner uygulaması, kullanıcı deneyimini iyileştirmek için aşağıdaki bilgileri toplar:

• Taradığınız QR kodların içeriği (cihazınızda yerel olarak saklanır)
• Oluşturduğunuz QR kodlar (cihazınızda yerel olarak saklanır)
• Uygulama kullanım tercihleri (tema, dil vb.)

Tüm veriler cihazınızda yerel olarak saklanır ve sunucularımıza gönderilmez.
''',
          ),
          _buildSection(
            title: '2. Kamera İzni',
            content: '''
QR kod tarama özelliğini kullanabilmek için kamera erişim izni gereklidir. Kamera sadece QR kod tarama sırasında kullanılır ve hiçbir görüntü kaydedilmez veya paylaşılmaz.
''',
          ),
          _buildSection(
            title: '3. Depolama İzni',
            content: '''
QR kodları resim olarak kaydetmek için depolama izni gerekebilir. Bu izin yalnızca sizin isteğiniz üzerine QR kod görsellerini kaydetmek için kullanılır.
''',
          ),
          _buildSection(
            title: '4. Veri Güvenliği',
            content: '''
Tüm verileriniz cihazınızda şifrelenerek saklanır. Hiçbir kişisel bilginiz üçüncü taraflarla paylaşılmaz.
''',
          ),
          _buildSection(
            title: '5. Reklamlar',
            content: '''
Uygulama, Google AdMob üzerinden reklamlar gösterebilir. AdMob, reklam gösterimi için cihaz bilgilerini kullanabilir. Daha fazla bilgi için Google'ın gizlilik politikasını inceleyebilirsiniz.
''',
          ),
          _buildSection(
            title: '6. Çocukların Gizliliği',
            content: '''
Uygulamamız 13 yaşın altındaki çocuklardan bilerek kişisel bilgi toplamaz. Ebeveynler, çocuklarının uygulamayı kullanımını denetlemelidir.
''',
          ),
          _buildSection(
            title: '7. Değişiklikler',
            content: '''
Bu gizlilik politikası zaman zaman güncellenebilir. Önemli değişiklikler olduğunda uygulama içinde bildirim yapılacaktır.
''',
          ),
          _buildSection(
            title: '8. İletişim',
            content: '''
Gizlilik politikası ile ilgili sorularınız için bizimle iletişime geçebilirsiniz.

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
