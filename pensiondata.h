#ifndef PENSIONDATA_H
#define PENSIONDATA_H

#include <QQmlEngine>
#include <QObject>
#include <QtQml/qqml.h>
#include <qqmlintegration.h>
#include <array>

class PensionData : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT
private:
    QString m_name                  {""};
    QString m_lastName              {""};
    QString m_afm                   {""};
    QString m_amka                  {""};
    bool    m_syntaxiBarea          {false};
    bool    m_syntaxiAnapiria       {false};
    int     m_posostoAnapirias      {0};
    int     m_ageYears              {67};
    int     m_ageMonths             {0};
    int     m_ensima                {0};
    int     m_residencyYears        {0};
    int     m_workMonthsSince2002   {0};
    double  m_medianIncomeSince2002 {1000.00};
    int     m_parallelMonths        {0};
    int     m_parallelYears         {0};
    int     m_totalExtraPaidMonths  {0};
    double  m_prosauksisiPA         {0};
    double  m_telikoPA              {0};
    int     m_epilegmenosForeas     {0};
    int     m_pre2002ParallelMonths {0};

    QLocale                         m_locale{QLocale::Greek};

    std::array<double, 25>          m_synola;
    std::array<double, 25>          m_deiktesTK;
    std::array<double, 25>          m_synolaTelika;

    std::unordered_map<int, double> m_posostaAnaplirosis;
    // 0. ΙΚΑ
    // 1. ΟΑΕΕ/ΕΤΑΑ
    // 2. ΔΗΜΟΣΙΟ
    // 3. ΟΓΑ
    std::array<std::array<std::array<double, 12>, 25>, 4>   m_incomeData;
    std::array<double, 25>                                  m_annualIncome;
    double                                                  m_totalIncomeSince2002{0};

    double      m_meiosiEtonAsfalisis       {0};
    double      m_meiosiEtonDiamonis        {0};
    double      m_meiosiPosostouAnapirias   {0};
    double      m_meiosiOriouIlikias        {0};
    double      m_totalNationalPension      {446.80};
    double      m_totalContributoryPension  {0};
    double      m_totalMainPensionMikta     {446.80};
    double      m_totalMainPensionKathara   {446.80};
    QString     m_finalText                 {""};
public:
    PensionData();
public slots:
    void insertBasicInfo(const QString& name,
                         const QString& lastName,
                         const QString& afm,
                         const QString& amka,
                         const QString& ageYears,
                         const QString& ageMonths,
                         const QString& syntaxiBarea,
                         const QString& syntaxiAnapiria,
                         const QString& posostoAnapirias,
                         const QString& residenceYears,
                         const QString& etiAsfalisis);

    void insertIncomeData(const QString& income,
                          const QString& foreas,
                          const QString& year,
                          const QString& month);
    void test();
    void calculateParallelMonths();
    void calculateExtraPeriods(const QString& totalMonths, const QString& lastIncome);
    void calculateNationalPension();
    void calculateContributoryPension();
    void setForeasParallilon(const QString& foreasIndex);
    void setPre2002ParallelMonths(const QString& pre2002ParallelMonths);
    void writeDocument(const QString& fileUrl);
signals:
};

#endif // PENSIONDATA_H
