//다음을 만족하는 MainboardEntity(메인보드 부품)을 찾는 사용자 쿼리
  //1. 입력받은 cpu의 소켓버전과 일치하는지
  //2. 입력받은 class(요구사항등급)에 해당하는지
  //3. 입력받은 ssd의 pcie버전을 지원하는지
@Query("SELECT m " +
        "FROM MainboardEntity m " +
        "WHERE m.socketInfo = :socketInfo " +
            "AND m.classColumn = :class " +
            "AND m.memorySpec = :memorySpec " +
            "AND CASE " +
                "WHEN :pcieVer=3 THEN m.pcie3 " +
                "WHEN :pcieVer=4 THEN m.pcie4 " +
                "WHEN :pcieVer=5 THEN m.pcie5 " +
            "END")
List<MainboardEntity> findBySocketAndClassAndMemoryAndPcie(
        @Param("socketInfo")String socketInfo,
        @Param("`class`")Integer classColumn,
        @Param("memorySpec")String memorySpec,
        @Param("pcieVer")Integer pcieVer
);
