void main() {
  final luas = hitungLuasPersegiPanjang(10.0, 5.0);

  print('Luas Persegi panjang : $luas');

  final profil = Profil(
    nama: 'Irfan Pandu',
    nim: '244107020193',
    email: 'irfanpandu@gmai;.com',
  );

  print('Nama: ${profil.nama}');
  print('NIM: ${profil.nim}');
  print('Email: ${profil.email ?? 'tidak ada'}');
}

double hitungLuasPersegiPanjang(double panjang, double lebar) {
  return panjang * lebar;
}

class Profil {
  final String nama;
  final String nim;
  final String? email;

  Profil({
    required this.nama,
    required this.nim,
    this.email,
  });
}