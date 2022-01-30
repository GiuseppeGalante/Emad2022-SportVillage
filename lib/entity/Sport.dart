enum Sport{
  calcio,
  pallavolo,
  padel,
  tennis,
  pingpong,
}

class SportClass
{
  late Sport ? sport;
  late List<int> partecipanti=[];

  SportClass(Sport sport)
  {
      partecipanti = [];
      this.sport = sport;
      if(sport ==Sport.calcio)
          partecipanti.add(10);
      else if(sport == Sport.pallavolo)
        partecipanti.add(12);
      else if(sport == Sport.padel) {
        partecipanti.add(2);
        partecipanti.add(4);
      }
      else if(sport == Sport.tennis) {
        partecipanti.add(2);
        partecipanti.add(4);
      }
      else if(sport== Sport.pingpong)
        partecipanti.add(2);
  }

}