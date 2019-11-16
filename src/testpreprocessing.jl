#=
testpreprocessing:
- Julia version: 
- Author: yusufrahadika
- Date: 2019-11-14
=#

include("preprocessing.jl")

println(Preprocessing.preprocess("""
     - Bagi banyak orang,  merupakan salah satu hal tersulit untuk dilakukan.
     Tidak peduli alarm yang sudah berbunyi, mereka bisa saja menunda alarm mereka dan kembali .
     Dikutip dari Popular Science, ternyata belum tentu kemalasan yang membuat orang-orang sulit untuk membuka mata mereka pada pagi hari.
     Bisa jadi hal ini disebabkan oleh waktu kerja tubuh yang tidak sesuai dengan tuntutan waktu memulai hari.
     Waktu kerja tubuh kita dikendalikan oleh nucleus suprachiasmatic, bagian dari otak yang mengendalikan ritme biologis tubuh.
     Jean Matheson, spesialis gangguan tidur di Beth Israel Medical Center di New York, mengatakan bahwa ritme alami yang sudah diatur tubuh ini sering kali tidak selaras dengan tuntutan waktu untuk memulai kegiatan.
     Ketidakselarasan ini bisa jadi diakibatkan oleh fase tidur yang tertunda.
     Salah satu penyebabnya adalah paparan cahaya artifisial yang dihasilkan oleh layar handphone, komputer, lampu baca, dan televisi.
     Otak sangat sensitif terhadap cahaya. Paparan cahaya terlalu banyak sebelum tidur dapat menipu otak untuk berpikir bahwa itu siang hari.
     Dikutip dari bustle.com, ada beberapa faktor lain yang membuat orang sulit bangun di pagi hari.
     Hal ini berperan dalam menentukan apakah kamu kesulitan bangun di pagi hari atau tidak.
     Kalau kamu tidak tidur dengan nyenyak, kamu akan tetap lelah tidak peduli seberapa siang kamu bangun.
     Sulit bangun pagi juga bisa berarti kamu kurang minum air putih.
     Para ahli merekomendasikan memulai hari dengan segelas air putih sebelum kamu minum kopi atau sarapan.
     Menurut sebuah studi dari 23andMe yang diterbitkan dalam jurnal Nature Communications, faktor genetik merupakan salah satu faktor mengapa beberapa orang merasa sulit untuk bangun pagi hari.
"""))