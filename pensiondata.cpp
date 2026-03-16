#include <QPdfWriter>
#include <QTextDocument>
#include <QPainter>
#include <QUrl>
#include "pensiondata.h"

PensionData::PensionData() {

    m_finalText.reserve(2000);
    m_posostaAnaplirosis.reserve(101);

    for (int i = 0; i < 15; ++i) {
        m_posostaAnaplirosis.insert({i, 11.55}); // Έως 15 έτη ασφάλισης
    }

    m_posostaAnaplirosis.insert({16, 12.39});
    m_posostaAnaplirosis.insert({17, 13.23});
    m_posostaAnaplirosis.insert({18, 14.07});
    m_posostaAnaplirosis.insert({19, 14.97});
    m_posostaAnaplirosis.insert({20, 15.87});
    m_posostaAnaplirosis.insert({21, 16.77});
    m_posostaAnaplirosis.insert({22, 17.73});
    m_posostaAnaplirosis.insert({23, 18.69});
    m_posostaAnaplirosis.insert({24, 19.65});
    m_posostaAnaplirosis.insert({25, 20.68});
    m_posostaAnaplirosis.insert({26, 21.71});
    m_posostaAnaplirosis.insert({27, 22.74});
    m_posostaAnaplirosis.insert({28, 23.95});
    m_posostaAnaplirosis.insert({29, 25.16});
    m_posostaAnaplirosis.insert({30, 26.37});
    m_posostaAnaplirosis.insert({31, 28.35});
    m_posostaAnaplirosis.insert({32, 30.33});
    m_posostaAnaplirosis.insert({33, 32.31});
    m_posostaAnaplirosis.insert({34, 34.81});
    m_posostaAnaplirosis.insert({35, 37.31});
    m_posostaAnaplirosis.insert({36, 39.81});
    m_posostaAnaplirosis.insert({37, 42.36});
    m_posostaAnaplirosis.insert({38, 44.91});
    m_posostaAnaplirosis.insert({39, 47.46});
    m_posostaAnaplirosis.insert({40, 50.01});

    double finalPerc = 50.00;

    for(int k = 41; k < 100; k++) {
        finalPerc += 0.50;
        m_posostaAnaplirosis.insert({k, finalPerc});
    }


    m_deiktesTK.at(0) = 1.57352; // 2002
    m_deiktesTK.at(1) = 1.52030;
    m_deiktesTK.at(2) = 1.47746;
    m_deiktesTK.at(3) = 1.42750;
    m_deiktesTK.at(4) = 1.38323;
    m_deiktesTK.at(5) = 1.34425;
    m_deiktesTK.at(6) = 1.29007;
    m_deiktesTK.at(7) = 1.27464;
    m_deiktesTK.at(8) = 1.21727; // 2010
    m_deiktesTK.at(9) = 1.17805;
    m_deiktesTK.at(10) = 1.16062;
    m_deiktesTK.at(11) = 1.17141;
    m_deiktesTK.at(12) = 1.18699;
    m_deiktesTK.at(13) = 1.20796;
    m_deiktesTK.at(14) = 1.21801;
    m_deiktesTK.at(15) = 1.20451;
    m_deiktesTK.at(16) = 1.19702;
    m_deiktesTK.at(17) = 1.19400;
    m_deiktesTK.at(18) = 1.20909;
    m_deiktesTK.at(19) = 1.19447;
    m_deiktesTK.at(20) = 1.08939;
    m_deiktesTK.at(21) = 1.05291;
    m_deiktesTK.at(22) = 1.02482;
    m_deiktesTK.at(23) = 1.00;
    m_deiktesTK.at(24) = 1.00; // 2026
}


void PensionData::insertIncomeData(const QString& income, const QString &foreas, const QString &year, const QString &month) {

    double result = m_locale.toDouble(income);
    int foreasIdx = foreas.toInt();
    int yearIdx = year.toInt();
    int monthIdx = month.toInt();

    if(foreasIdx == 1 || foreasIdx == 3) {
        result *= 5;
    }

    if(foreasIdx == 2 && yearIdx > 4 && yearIdx < 13) {
        if(income.toDouble() > 0.00) {
            result += 140.00;
        }
    }

    m_incomeData[foreasIdx][yearIdx][monthIdx] = result;
}


void PensionData::insertBasicInfo(const QString& name,
                                  const QString& lastName,
                                  const QString& afm,
                                  const QString& amka,
                                  const QString& ageYears,
                                  const QString& ageMonths,
                                  const QString& syntaxiBarea,
                                  const QString& syntaxiAnapiria,
                                  const QString& posostoAnapirias,
                                  const QString& residenceYears,
                                  const QString& etiAsfalisis) {
    m_name = name;
    m_lastName = lastName;
    m_afm = afm;
    m_amka = amka;

    m_ageYears = ageYears.toInt();
    m_ageMonths = ageMonths.toInt();
    m_syntaxiBarea = static_cast<bool>(syntaxiBarea.toInt());
    m_syntaxiAnapiria = static_cast<bool>(syntaxiAnapiria.toInt());
    m_posostoAnapirias = posostoAnapirias.toInt();
    m_residencyYears = residenceYears.toInt();
    m_ensima += etiAsfalisis.toInt() * 300;
}

void PensionData::test() {
    // for (std::array y : m_incomeData[0]) {

    //     for (double m : y) {
    //         std::cout << m << '\n';
    //     }

    // }
}

void PensionData::setForeasParallilon(const QString& foreasIndex) {
    m_epilegmenosForeas = foreasIndex.toInt();
}

void PensionData::setPre2002ParallelMonths(const QString &pre2002ParallelMonths) {
    m_pre2002ParallelMonths = pre2002ParallelMonths.toInt();
}

void PensionData::calculateParallelMonths() {

    // Για κάθε μήνα ελέγχουμε εάν έχουν καταχωρηθεί πολλαπλές αποδοχές.
    // Εάν ναι διαγράφουμε όλες τις καταχωρήσεις του μήνα εκτός από τον επιλεγμένο φορέα.
    // Οι διαγεγραμμένες καταχωρήσεις μετατρέπονται σε προσαύξηση του ποσοστού αναπλήρωσης.
    for (int i = 0; i < m_incomeData[0].size(); i++) {
        for (int k = 0; k < m_incomeData[0][0].size(); ++k) {

            std::vector<int> monthlyIncomeIndex; // Εάν ξεπεράσει το 1 σημαίνει ότι έχουμε πολλαπλές καταχωρήσεις
            monthlyIncomeIndex.reserve(4);

            // Ελέγχει τα τέσσερα κελιά εκάστου μηνός του τρισδιάστατου πίνακα.
            for (int r = 0; r < 4; r++) {
                if(m_incomeData[r][i][k] > 0.00) {
                    if(monthlyIncomeIndex.size() == 0) {
                        m_workMonthsSince2002++;
                    }
                    monthlyIncomeIndex.push_back(r);
                }
                // Εάν βρεθεί παράλληλος χρόνος:
                if(monthlyIncomeIndex.size() > 1) {
                    // Εάν επιλεγεί το ΙΚΑ
                    if(m_epilegmenosForeas == 0 && m_incomeData[0][i][k] > 0.00) { // Η δεύτερη προϋπόθεση υπάρχει επειδή είναι πιθανό ο χρήστης να καταχωρήσει λάθος απάντηση
                        m_parallelMonths++;
                        m_incomeData[1][i][k] = 0.00; // Διαγράφουμε τις άλλες καταχωρήσεις
                        m_incomeData[2][i][k] = 0.00;
                        m_incomeData[3][i][k] = 0.00;
                    }
                    // Εάν επιλεγεί ΟΑΕΕ/ΕΤΑΑ
                    else if(m_epilegmenosForeas == 1 && m_incomeData[1][i][k] > 0.00) {
                        m_parallelMonths++;
                        m_incomeData[0][i][k] = 0.00;
                        m_incomeData[2][i][k] = 0.00;
                        m_incomeData[3][i][k] = 0.00;
                    }
                    // Εάν επιλεγεί ΔΗΜΟΣΙΟ
                    else if(m_epilegmenosForeas == 2 && m_incomeData[2][i][k] > 0.00) {
                        m_parallelMonths++;
                        m_incomeData[0][i][k] = 0.00;
                        m_incomeData[1][i][k] = 0.00;
                        m_incomeData[3][i][k] = 0.00;
                    }
                    // Εάν επιλεγεί ΟΓΑ
                    else if(m_epilegmenosForeas == 3 && m_incomeData[3][i][k] > 0.00) {
                        m_parallelMonths++;
                        m_incomeData[0][i][k] = 0.00;
                        m_incomeData[1][i][k] = 0.00;
                        m_incomeData[2][i][k] = 0.00;
                    }
                    // Εάν επιλεγεί λάθος φορέας αλλά υπάρχει πολλαπλή καταχώρηση!
                    else {
                        m_parallelMonths++;
                        for (int v : monthlyIncomeIndex) {

                            if(m_incomeData[v][i][k] != m_incomeData[monthlyIncomeIndex.at(0)][i][k]) {

                                m_incomeData[v][i][k] = 0.00;
                            }
                        }
                    }
                }
            }
        }

    }

    m_parallelMonths += m_pre2002ParallelMonths;
    m_parallelYears = m_parallelMonths / 12;
    m_prosauksisiPA +=  m_parallelYears * 20.00 * 0.075; // Βάζουμε εισφορά 20% αν και δεν είναι πάντα σωστό
}

void PensionData::calculateExtraPeriods(const QString &totalMonths, const QString &lastIncome) {

    m_totalExtraPaidMonths += totalMonths.toInt();
    m_ensima += totalMonths.toInt() * 25;
    m_workMonthsSince2002 += totalMonths.toInt();
    m_totalIncomeSince2002 += lastIncome.toDouble() * totalMonths.toDouble();

}

void PensionData::calculateNationalPension() {

    double currentNationalPension = 446.80;

    int etiAsfalisis = m_ensima / 300;

    // 1. Μείωση λόγω ετών ασφάλισης
    if(etiAsfalisis < 15) etiAsfalisis = 15;

    if(etiAsfalisis < 20) {
        m_meiosiEtonAsfalisis = (20 - etiAsfalisis) * 0.02 * currentNationalPension;
        currentNationalPension -= m_meiosiEtonAsfalisis;
    }

    // 2. Μείωση λόγω ετών διαμονής

    if(m_residencyYears < 40) {
        m_meiosiEtonDiamonis = (40 - m_residencyYears) * currentNationalPension / 40.00;
        currentNationalPension -= m_meiosiEtonDiamonis;
    }

    // 3. Μείωση λόγω ορίου ηλικίας
    if(m_ageYears < 67 && !m_syntaxiBarea && !m_syntaxiAnapiria && m_ensima < 12000) {
        int diaforaMinon = (67 * 12) - ((m_ageYears * 12) + m_ageMonths);
        m_meiosiOriouIlikias = diaforaMinon * 0.005 * currentNationalPension;
        currentNationalPension -= m_meiosiOriouIlikias;
    }

    // 4. Μείωση λόγω ποσοστού αναπηρίας
    if(m_syntaxiAnapiria) {
        if(m_posostoAnapirias < 67) {
            m_meiosiPosostouAnapirias = currentNationalPension / 2;
            currentNationalPension -= m_meiosiPosostouAnapirias;
        }
        else if(m_posostoAnapirias >= 67 && m_posostoAnapirias < 80) {
            m_meiosiPosostouAnapirias = currentNationalPension * 0.25;
            currentNationalPension -= m_meiosiPosostouAnapirias;
        }

    }

    m_totalNationalPension = currentNationalPension;

}

void PensionData::calculateContributoryPension() {

    // 1. Εύρεση συνόλου αποδοχών
    for (int i = 0; i < m_incomeData[0].size(); i++) {

        m_synola[i] = 0;

        for (int k = 0; k < m_incomeData[0][0].size(); ++k) {

            for(int r = 0; r < 4; r++) {
                if(m_incomeData[r][i][k] > 0.00) {
                    m_synola[i] += m_incomeData[r][i][k];
                }
            }
        }

        m_synolaTelika[i] = m_synola[i];
        m_synolaTelika[i] *= m_deiktesTK.at(i);
        m_totalIncomeSince2002 += m_synolaTelika.at(i);
    }


    // 2. Εύρεση συνολικών μηνών εργασίας από το 2002

    // 3. Μέσος όρος από το 2002
    m_medianIncomeSince2002 = m_totalIncomeSince2002 / m_workMonthsSince2002;

    // 4. Καθορισμός συνολικού ποσοστού αναπλήρωσης
    m_telikoPA += m_prosauksisiPA;
    m_telikoPA += m_posostaAnaplirosis.at(m_ensima / 300);

    // 5. Τελική πράξη
    m_totalContributoryPension = m_medianIncomeSince2002 * m_telikoPA / 100.00;
    m_totalMainPensionMikta = m_totalNationalPension + m_totalContributoryPension;
    m_totalMainPensionKathara = m_totalMainPensionMikta * 0.94;

}


void PensionData::writeDocument(const QString &fileUrl) {

    QString filePath = QUrl(fileUrl).toLocalFile();
    QPdfWriter writer{filePath};
    writer.setPageSize(QPageSize(QPageSize::A4));
    writer.setPageMargins(QMarginsF(20,20,20,20));
    writer.setResolution(100);
    writer.setAuthor("Dimitris Daletsos");
    QTextDocument doc;

    // 1. ΒΑΣΙΚΑ ΣΤΟΙΧΕΙΑ

    m_finalText.append("<style>body{font-size: 12pt; font-family: \"Georgia\"; word-wrap: break-word;} h3, h2 { text-align: center; }</style>\n");
    m_finalText.append("<h3>ΕΝΗΜΕΡΩΤΙΚΟ ΕΝΤΥΠΟ ΥΠΟΛΟΓΙΣΜΟΥ ΠΟΣΟΥ ΣΥΝΤΑΞΕΩΝ</h3>\n");
    m_finalText.append("<p>Όνομα: " + m_name + "</p>\n");
    m_finalText.append("<p>Επίθετο: " + m_lastName + "</p>\n");
    m_finalText.append("<p>Α.Φ.Μ: " + m_afm + "</p>\n");
    m_finalText.append("<p>Α.Μ.Κ.Α: " + m_amka + "</p>\n");

    // 2. Εθνική σύνταξη

    m_finalText.append("<h3>A. ΥΠΟΛΟΓΙΣΜΟΣ ΕΘΝΙΚΗΣ ΣΥΝΤΑΞΗΣ.</h3>\n");
    m_finalText.append("<p>Πλήρες ποσό εθνικής σύνταξης: 446,80€.</p>\n");

    if(m_syntaxiAnapiria) {
        m_finalText.append("<p>Κατηγορία σύνταξης: Σύνταξη αναπηρίας.</p>\n");
    }
    else {
        m_finalText.append("<p>Κατηγορία σύνταξης: Σύνταξη γήρατος.</p>\n");
        if(m_syntaxiBarea) {
            m_finalText.append("<p>Θεμελίωση βάσει διατάξεων Κ.Β.Α.Ε: ΝΑΙ.</p>\n");
        }
        else {
            m_finalText.append("<p>Θεμελίωση βάσει διατάξεων Κ.Β.Α.Ε: ΟΧΙ.</p>\n");
        }

        if(m_ensima >= 12000) {
            m_finalText.append("<p>Κατοχύρωση με 40 έτη ασφάλισης: ΝΑΙ.</p>\n");
        }
        else {
            m_finalText.append("<p>Κατοχύρωση με 40 έτη ασφάλισης: OXI.</p>\n");
        }

    }

    m_finalText.append("<p>Μείωση λόγω ετών ασφάλισης (λιγότερα από 20): " + std::to_string(m_meiosiEtonAsfalisis) + "€.</p>\n");
    m_finalText.append("<p>Μείωση λόγω ετών διαμονής (λιγότερα από 40): " + std::to_string(m_meiosiEtonDiamonis) + "€.</p>\n");

    if(m_syntaxiAnapiria) {
        m_finalText.append("<p>Μείωση λόγω ποσοστού αναπηρίας (μικρότερο από 80): " + std::to_string(m_meiosiPosostouAnapirias) + "€.</p>\n");
    }
    else {
        m_finalText.append("<p>Μείωση λόγω ορίου ηλικίας: " + std::to_string(m_meiosiOriouIlikias) + "€.</p>\n");
    }

    m_finalText.append("<p><b>Τελικό ποσό εθνικής σύνταξης: " + std::to_string(m_totalNationalPension) + "€.</b></p>\n");

    // 3. Ανταποδοτική σύνταξη

    m_finalText.append("<h3>B. ΥΠΟΛΟΓΙΣΜΟΣ ΑΝΤΑΠΟΔΟΤΙΚΗΣ ΣΥΝΤΑΞΗΣ.</h3>\n");

    // 3α. Πίνακας αποδοχών

    m_finalText.append("<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">\n");
    m_finalText.append("<tr><th>ΕΤΟΣ</th><th>ΑΠΟΔΟΧΕΣ</th><th>Δ.Τ.Κ.</th><th>ΤΕΛΙΚΟ</th></tr>\n");

    for(int i = 0; i < m_synola.size(); i++) {
        m_finalText.append("<tr><td>" + std::to_string(i + 2002) + "</td><td>" + std::to_string(m_synola[i]) + "</td><td>" + std::to_string(m_deiktesTK[i]) + "</td><td>" + std::to_string(m_synolaTelika[i]) + "</td></tr>\n");
    }

    m_finalText.append("<tr><td>ΣΥΝΟΛΟ:</td><td> </td><td> </td><td>" + std::to_string(m_totalIncomeSince2002) + "</td></tr>\n");
    m_finalText.append("</table>\n");


    m_finalText.append("<p><b>Σύνολο αποδοχών από το 2002: " + std::to_string(m_totalIncomeSince2002) + "€.</b></p>\n");
    m_finalText.append("<p><b>Σύνολο μηνών ασφάλισης από το 2002: " + std::to_string(m_workMonthsSince2002) + ".</b></p>\n");
    m_finalText.append("<p><b>Μέσος όρος αποδοχών από το 2002: " + std::to_string(m_medianIncomeSince2002) + "€.</b></p>\n");

    m_finalText.append("<p>Ποσοστό αναπλήρωσης που ισχύει για " + std::to_string(m_ensima / 300) + " έτη ασφάλισης: " + std::to_string(m_posostaAnaplirosis.at(m_ensima / 300)) + "%.</p>\n");
    m_finalText.append("<p>Έτη παράλληλης ασφάλισης: " + std::to_string(m_parallelYears) + " έτη.</p>\n");
    m_finalText.append("<p>Σύνολο μηνών εξαγοράς πλασματικών χρόνων: " + std::to_string(m_totalExtraPaidMonths) + " έτη.</p>\n");
    m_finalText.append("<p>Προσαύξηση ποσοστού αναπλήρωσης: " + std::to_string(m_prosauksisiPA) + "%.</p>\n");
    m_finalText.append("<p><b>Συνολικό ποσοστό αναπλήρωσης: " + std::to_string(m_telikoPA) + "%.</b></p>\n");

    m_finalText.append("<p><b>Ανταποδοτική σύνταξη: " + std::to_string(m_totalContributoryPension) + "€.</b></p>\n");

    m_finalText.append("<p><b>Σύνολο κύριας σύνταξης: " + std::to_string(m_totalMainPensionMikta) + "€.</b></p>\n");
    m_finalText.append("<p><b>Σύνολο κύριας σύνταξης (καθαρό ποσό): " + std::to_string(m_totalMainPensionKathara) + "€.</b></p>\n");

    QFont font{"Segoe UI"};
    doc.setDefaultFont(font);
    doc.setPageSize(writer.pageLayout().paintRectPoints().size());
    doc.setHtml(m_finalText);

    //QPainter painter(&writer);
    //painter.setClipping(false);
    //painter.scale(20.0, 20.0);

    doc.print(&writer);

}
