//다음을 만족하는 ChassisEntity(케이스)를 찾는 사용자 쿼리
  //1. 메인보드의 크기규격(~~_atx)을 만족하는지
  //2. GPU의 길이 + 15mm의 여유공간을 갖는지
@Query("SELECT c " +
        "FROM ChassisEntity c " +
        "WHERE " +
            "CASE " +
                "WHEN :size='mini_itx' THEN c.miniItx " +
                "WHEN :size='micro_atx' THEN c.microAtx " +
                "WHEN :size='standard_atx' THEN c.standardAtx " +
                "WHEN :size='extended_atx' THEN c.extendedAtx " +
                "ELSE FALSE " +
            "END " +
        "AND c.depth > :width + 15")
List<ChassisEntity> findBySizeAndDepth(@Param("size")String size, @Param("width")BigDecimal width);
